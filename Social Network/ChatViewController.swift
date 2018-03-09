import UIKit
import Typist

final class ChatViewController: UIViewController {

    // MARK: - Internal properties

    var userID: UserID? {
        didSet {
            guard let userID = userID else { return }
            MessagesService.default.subcribe(self, for: userID)
        }
    }

    // MARK: - Outlets

    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var translateButton: UIButton!
    @IBOutlet private weak var messageTextView: UITextView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var userPictureBarButtonItem: UIBarButtonItem!

    @IBOutlet private weak var textViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet private weak var bottomSheetContainer: UIView!
    @IBOutlet private weak var bottomSheetBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var bottomSheetHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var textFieldContainerBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var dimmerView: UIView!

    // MARK: - Private properties

    private var messages: [MessageProtocol] = []
    private var comments: [MessageID:[CommentProtocol]] = [:]
    private var messagesWithUnhiddenComments: Set<MessageID> = []

    private let keyboardHandler = Typist.shared
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
        updateController()
        configureUIMenuController()
        configureKeyboardHandler()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50

        if !messages.isEmpty {
            let indexPath = IndexPath(row: messages.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onTextViewDidChange(_:)),
                                               name: .UITextViewTextDidChange,
                                               object: messageTextView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToNotifications()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        guard let userID = userID else { return }
        MessagesService.default.unsubscribe(self, from: userID)
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

        viewController.userID = userID
    }

    private func prepareBottomSheetViewController(_ viewController: UIViewController) {
        guard let viewController = viewController as? ChatBottomSheetViewController else { return }
        bottomSheet = viewController
        bottomSheet?.delegate = self
    }

    private func updateController() {
        guard let userID = userID else { return }

        UserManager.shared.getUser(with: userID) { user in
            guard let user = user else { return }

            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }

                self.navigationItem.title = user.name
                self.updateMessages(with: MessagesService.default.storage[userID])
            }
        }
    }

    private func updateMessages(with messages: [MessageProtocol]) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            var commentIDs: Set<MessageID> = []
            for message in messages where message.type == .comment {
                guard let comment = message as? CommentProtocol else { continue }
                if let commentID = comment.id {
                    commentIDs.insert(commentID)
                }

                if self?.comments[comment.parentID] == nil {
                    self?.comments[comment.parentID] = []
                }

                if let comments = self?.comments[comment.parentID],
                    !comments.contains(where: { $0.id == comment.id }) {
                    self?.comments[comment.parentID]?.append(comment)
                }
            }

            DispatchQueue.main.async {
                self?.messages = messages.filter {
                    if let commentID = $0.id {
                        return !commentIDs.contains(commentID)
                    }
                    else {
                        return true
                    }
                }
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - IBActions

    @IBAction func onTranslateButtonPressed(_ sender: UIButton) {
        presentBottomSheet(strategy: .imageTranslation)
    }

    @IBAction private func sendMessage(_ sender: Any) {
        guard let text = messageTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else {
            return
        }

        guard let userID = userID, let data = text.data(using: .utf16),
            let senderID = SocialNetworkClient.Settings.userId else {
                return
        }

        let message = Message(senderID: senderID, data: data, dataType: .text)
        MessagesService.default.send(message, to: userID) { request in

        }
        messages.append(message)

        tableView.reloadData()
        messageTextView.text = ""
        textViewHeightConstraint.constant = messageTextView.contentSize.height
        sendButton.isEnabled = false

        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
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

    @objc private dynamic func onTextViewDidChange(_ notification: Notification) {
        textViewHeightConstraint.constant = messageTextView.contentSize.height
        sendButton.isEnabled = !messageTextView.text.isEmpty
    }

    @objc private dynamic func translateSelected(_ notification: Notification) {
        guard let text = notification.object as? LSExtractedWord else {
            return
        }

        presentBottomSheet(strategy: .translation, for: text)
    }

    @objc private dynamic func commentSelected(_ notification: Notification) {
        guard let commentedText = notification.object as? CommentedText else {
            return
        }

        let alertController = UIAlertController(title: "Comment", message: commentedText.text, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter your comment..."
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        let sendAction = UIAlertAction(title: "Send", style: .default) { [weak alertController, weak self] _ in
            guard let text = alertController?.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let data = text.data(using: .utf16),
                let senderID = SocialNetworkClient.Settings.userId,
                let `self` = self,
                let messageID = self.messages[commentedText.tag].id,
                let userID = self.userID else { return }

            let comment = Comment(senderID: senderID,
                                  data: data,
                                  dataType: .text,
                                  startPosition: commentedText.start,
                                  endPosition: commentedText.end,
                                  messageID: messageID)

            MessagesService.default.send(comment, to: userID) { request in

            }
        }
        alertController.addAction(sendAction)

        present(alertController, animated: true, completion: nil)
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

    // MARK: - Private methods

    private func presentBottomSheet(strategy: ChatBottomSheetViewControllerStrategy, for text: LSExtractedWord? = nil) {
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
        NotificationCenter.default.addObserver(self, selector: #selector(translateSelected(_:)),
                                               name: .translateSelected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(commentSelected(_:)),
                                               name: .commentSelected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(lookUpSelected(_:)),
                                               name: .lookUpSelected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addSelectedToDictionary(_:)),
                                               name: .addSelectedToDictionary, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(testFoo(_:)),
                                               name: NSNotification.Name("FooBar"), object: nil)
    }

    @objc private dynamic func testFoo(_ notification: Notification) {
        guard let text = notification.object as? String, !text.isEmpty else { return }

        messageTextView.text.append(contentsOf: " \(text)")
        NotificationCenter.default.post(name: .UITextViewTextDidChange, object: messageTextView)

        if let bottomSheet = bottomSheet {
            onBottomSheetDragDown(bottomSheet)
        }
    }

    private func configureUIMenuController() {
        let translateMenuItem = UIMenuItem(title: "Translate", action: #selector(ChatViewController.translateSelected(_:)))
        let commentMenuItem = UIMenuItem(title: "Comment", action: #selector(ChatViewController.commentSelected(_:)))
        let lookUpMenuItem = UIMenuItem(title: "Look Up", action: #selector(ChatViewController.lookUpSelected(_:)))
        let addToDictionaryMenuItem = UIMenuItem(title: "Add to Dictionary", action: #selector(ChatViewController.addSelectedToDictionary(_:)))
        UIMenuController.shared.menuItems = [translateMenuItem, commentMenuItem, lookUpMenuItem, addToDictionaryMenuItem]
    }

    private func configureKeyboardHandler() {
        keyboardHandler
            .on(event: .willShow) { [weak self] options in
                let keyboardWillHide = (options.endFrame.origin.y > options.startFrame.origin.y)
                self?.updateLayout(with: options.endFrame, keyboardWillHide: keyboardWillHide)
            }
            .on(event: .willHide) { [weak self] options in
                let keyboardWillHide = (options.endFrame.origin.y > options.startFrame.origin.y)
                self?.updateLayout(with: options.endFrame, keyboardWillHide: keyboardWillHide)
            }
            .start()
    }

    private func updateLayout(with keyboardFrame: CGRect, keyboardWillHide: Bool) {
        let animations: () -> Void = { [weak self] in
            self?.textFieldContainerBottomConstraint.constant = keyboardWillHide
                ? 0.0
                : keyboardFrame.size.height
            self?.view.layoutIfNeeded()
        }

        let completion: (Bool) -> Void = { [weak self] _ in
            guard let `self` = self, !self.messages.isEmpty, !keyboardWillHide else { return }

            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }

        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: animations,
                       completion: completion)
    }

}

extension ChatViewController: MessagesServiceObserver {

    func onUpdate(service: MessagesService) {

    }

    func onUpdate(from userID: UserID, service: MessagesService) {
        let shouldScrollToBottom = (messages.count < service.storage[userID].count)
        updateMessages(with: service.storage[userID])

        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            if shouldScrollToBottom {
                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
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
        let message = messages[indexPath.row]

        let comments: [CommentProtocol]?
        let commentsHidden: Bool
        if let messageID = message.id {
            comments = self.comments[messageID]
            commentsHidden = !messagesWithUnhiddenComments.contains(messageID)
        }
        else {
            comments = []
            commentsHidden = true
        }

        let identifier = (message.senderID == SocialNetworkClient.Settings.userId)
            ? "YourMessageCell"
            : "TheirMessageCell"

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! MessageTableViewCell
        cell.configure(message: message, comments: comments, commentsHidden: commentsHidden)
        cell.position = indexPath.row

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

}

// MARK: - UITableViewDelegate protocol

extension ChatViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let messageID = messages[indexPath.row].id else { return }

        if messagesWithUnhiddenComments.contains(messageID) {
            messagesWithUnhiddenComments.remove(messageID)
        }
        else {
            messagesWithUnhiddenComments.insert(messageID)
        }

        tableView.performBatchUpdates({
            tableView.reloadRows(at: [indexPath], with: .automatic)
        })
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
