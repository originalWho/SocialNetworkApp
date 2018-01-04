import UIKit

final class ChatViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var messageTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var userPictureBarButtonItem: UIBarButtonItem!

    @IBOutlet private weak var bottomSheetContainer: UIView!
    @IBOutlet private weak var bottomSheetBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var bottomSheetHeightConstraint: NSLayoutConstraint!

    @IBOutlet private weak var dimmerView: UIView!

    private var bottomSheetAnimationDuration: TimeInterval = 0.2
    private var bottomSheet: ChatBottomSheetViewController?

    private var isBottomSheetHidden: Bool = true {
        didSet {
            guard oldValue != isBottomSheetHidden else { return }
            bottomSheetBottomConstraint.constant = isBottomSheetHidden
                ? -bottomSheetHeightConstraint.constant
                : 0
            bottomSheet?.view.alpha = isBottomSheetHidden ? 0.0 : 1.0
            bottomSheetContainer.isUserInteractionEnabled = !isBottomSheetHidden
            dimmerView.alpha = isBottomSheetHidden ? 0.0 : 0.45
            view.layoutIfNeeded()
        }
    }

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIMenuController()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromNotifications()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }

        switch identifier {
        case .showProfileViewController:
            prepareProfileViewController(segue.destination)

        case .embedChatBottomSheetViewController:
            prepareBottomSheetViewController(segue.destination)

        case .presentDictionaryViewController:
            prepareDictionaryViewController(segue.destination)

        default:
            return
        }
    }

    private func prepareDictionaryViewController(_ viewController: UIViewController) {
        guard let navigationController = viewController as? UINavigationController,
            let viewController = navigationController.viewControllers.first as? DictionaryViewController else {
                return
        }

        viewController.prepareForModalPresentation()
    }

    private func prepareProfileViewController(_ viewController: UIViewController) {
        guard let viewController = viewController as? ProfileViewController else {
            return
        }
    }

    private func prepareBottomSheetViewController(_ viewController: UIViewController) {
        guard let viewController = viewController as? ChatBottomSheetViewController else { return }
        bottomSheet = viewController
        bottomSheet?.delegate = self
    }

    var id = [
        "TheirMessageCell",
        "YourMessageCell"
    ]

    var messages = [
        "Hello my friend, I expected to see you",
        "What a beautiful day to develop some kind of app!",
        "Imagine all the people\nLiving life in peace",
        "To be or not to be? Two bee or not two bee?",
        "I know what you did"
    ]

//    var translationHistory = [[String:String]]()

    // MARK: - IBActions

    @IBAction private func enableSendButton(_ sender: Any) {
        guard let text = messageTextField.text, !text.isEmpty else {
            sendButton.isEnabled = false
            return
        }

        sendButton.isEnabled = true
    }
    
    @IBAction private func sendMessage(_ sender: Any) {
        guard let text = messageTextField.text, !text.isEmpty else {
            return
        }

        messages.append(text)
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.messageTextField.text = ""
            self.sendButton.isEnabled = false
        }
    }

    @IBAction func onActionButtonPressed(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let openDictionaryAction = UIAlertAction(title: "Open Dictionary", style: .default) { [weak self] _ in
            self?.performSegue(withIdentifier: .presentDictionaryViewController, sender: self)
        }
        let openTranslateHistoryAction = UIAlertAction(title: "Open Translate History", style: .default) { [weak self] _ in
            self?.performSegue(withIdentifier: .presentTranslationHistoryViewController, sender: self)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        actionSheet.addAction(openDictionaryAction)
        actionSheet.addAction(openTranslateHistoryAction)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }

    // MARK: - Notifications

    @objc private dynamic func translateSelected(_ notification: Notification) {
        guard let text = notification.object as? LSExtractedWord else {
            return
        }

        presentBottomSheet(strategy: .translation, for: text)
    }

    @objc private dynamic func commentSelected(_ notification: Notification) {
        guard let text = notification.object as? LSExtractedWord else {
            return
        }

        presentBottomSheet(strategy: .comment, for: text)
    }

    @objc private dynamic func lookUpSelected(_ notification: Notification) {
        guard let extractedWord = notification.object as? LSExtractedWord else {
            return
        }

        presentBottomSheet(strategy: .lookUp, for: extractedWord)
    }

    @objc private dynamic func addSelectedToDictionary(_ notification: Notification) {
        guard let extractedWord = notification.object as? LSExtractedWord else {
            return
        }

        DictionaryManager.shared.add(entry: extractedWord.dictionaryEntry)
    }

    @objc private dynamic func keyboardWillShow(_ notification: Notification) {
        let keyboardHeight = getKeyboardHeight(notification)
        let offset = getOffset(notification)
        if keyboardHeight == offset {
            self.view.frame.origin.y -= keyboardHeight
        } else {
            self.view.frame.origin.y += keyboardHeight - offset
        }
    }

    @objc private dynamic func keyboardWillHide(_ notification: Notification) {
        if self.view.frame.origin.y < 0 {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }

    // MARK: - Private methods

    private func presentBottomSheet(strategy: ChatBottomSheetViewControllerStrategy, for text: LSExtractedWord) {
        bottomSheet?.configure(for: strategy, with: text)

        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }

            let animations: () -> Void = {
                self.isBottomSheetHidden = false
            }
            UIView.animate(withDuration: self.bottomSheetAnimationDuration,
                           delay: 0.0,
                           options: .curveEaseInOut,
                           animations: animations,
                           completion: nil)
        }
    }

    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(translateSelected(_:)),
                                               name: .translateSelected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(commentSelected(_:)),
                                               name: .commentSelected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(lookUpSelected(_:)),
                                               name: .lookUpSelected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addSelectedToDictionary(_:)),
                                               name: .addSelectedToDictionary, object: nil)
    }

    private func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    private func configureUIMenuController() {
        let translateMenuItem = UIMenuItem(title: "Translate", action: #selector(ChatViewController.translateSelected(_:)))
        let commentMenuItem = UIMenuItem(title: "Comment", action: #selector(ChatViewController.commentSelected(_:)))
        let lookUpMenuItem = UIMenuItem(title: "Look Up", action: #selector(ChatViewController.lookUpSelected(_:)))
        let addToDictionaryMenuItem = UIMenuItem(title: "Add to Dictionary", action: #selector(ChatViewController.addSelectedToDictionary(_:)))
        UIMenuController.shared.menuItems = [translateMenuItem, commentMenuItem, lookUpMenuItem, addToDictionaryMenuItem]
    }

    private func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }

    private func getOffset(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let offset = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return offset.cgRectValue.height
    }

}

extension ChatViewController: ChatBottomSheetViewControllerDelegate {

    func onBottomSheetDragDown(_ bottomSheetViewController: ChatBottomSheetViewController) {
        let animations: () -> Void = { [weak self] in
            self?.isBottomSheetHidden = true
        }
        UIView.animate(withDuration: bottomSheetAnimationDuration,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: animations,
                       completion: nil)
    }

}

// MARK: - UITableViewDataSource protocol

extension ChatViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = id[indexPath.row % id.count]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! MessageTableViewCell
        cell.configure(message: messages[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

}

// MARK: - Storyboard Segue Identifiers

private extension String {

    static var showProfileViewController: String {
        return "showProfileViewController"
    }

    static var embedChatBottomSheetViewController: String {
        return "embedChatBottomSheetViewController"
    }

    static var presentDictionaryViewController: String {
        return "presentDictionaryViewController"
    }

    static var presentTranslationHistoryViewController: String {
        return "presentTranslationHistoryViewController"
    }

}
