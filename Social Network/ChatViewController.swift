import UIKit

final class ChatViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var translateButton: UIButton!
    @IBOutlet private weak var messageTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var userPictureBarButtonItem: UIBarButtonItem!

    // MARK: - Private properties

    fileprivate let translateService: TranslateService = YandexTranslate()

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToNotifications()
        configureUIMenuController()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
    }

    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromNotifications()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }

        switch identifier {
        case .showProfileViewController:
            prepareProfileViewController(segue.destination)

        default:
            return
        }
    }

    private func prepareProfileViewController(_ viewController: UIViewController) {
        guard let viewController = viewController as? ProfileViewController else {
            return
        }
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
    
    @IBAction private func showTranslateHistory(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: UIStoryboard.ChatPage) as! ChatPageViewController
//        vc.translationHistory = translationHistory
//        present(vc, animated: true, completion: nil)
    }

    @IBAction private func enableSendButton(_ sender: Any) {
        guard let text = messageTextField.text, !text.isEmpty else {
            sendButton.isEnabled = false
            translateButton.isEnabled = false
            translateButton.imageView?.image = #imageLiteral(resourceName: "Translation-Disabled")
            return
        }

        sendButton.isEnabled = true
        translateButton.isEnabled = true
        translateButton.imageView?.image = #imageLiteral(resourceName: "Translation-Enabled")
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
            self.translateButton.isEnabled = false
            self.translateButton.imageView?.image = #imageLiteral(resourceName: "Translation-Disabled")
        }
    }

    @IBAction private func translateEntered(_ sender: Any) {
        guard let text = messageTextField.text, !text.isEmpty else {
            return
        }

        presentTranslateBottomSheetView(with: text) { [weak self] bottomSheet in
            guard let this = self else {
                return
            }

            this.translateService.translate(text) { translated in
                guard let translated = translated else {
                    bottomSheet?.setTranslated(text: "ERROR: Couldn't translate.", with: this.translateService)
                    return
                }

                bottomSheet?.setTranslated(text: translated, with: this.translateService)
//                let translation = [text: translated]
//                this.translationHistory.append(translation)
            }
        }
    }

    // MARK: - Notifications

    private dynamic func translateSelected(_ notification: Notification) {
        guard let text = notification.object as? String else {
            return
        }

        presentTranslateBottomSheetView(with: text) { [weak self] bottomSheet in
            guard let this = self else {
                return
            }

            this.translateService.translate(text) { translated in
                guard let translated = translated else {
                    bottomSheet?.setTranslated(text: "ERROR: Couldn't translate.", with: this.translateService)
                    return
                }
                
                bottomSheet?.setTranslated(text: translated, with: this.translateService)
//                let translation = [text: translated]
//                this.translationHistory.append(translation)
            }
        }
    }

    private dynamic func commentSelected(_ notification: Notification) {
        guard let text = notification.object as? String else {
            return
        }

        print(text)
    }

    private dynamic func keyboardWillShow(_ notification: Notification) {
        let keyboardHeight = getKeyboardHeight(notification)
        let offset = getOffset(notification)
        if keyboardHeight == offset {
            self.view.frame.origin.y -= keyboardHeight
        } else {
            self.view.frame.origin.y += keyboardHeight - offset
        }
    }

    private dynamic func keyboardWillHide(_ notification: Notification) {
        if self.view.frame.origin.y < 0 {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }

    // MARK: - Private methods

    private func presentTranslateBottomSheetView(with text: String, completion: @escaping (TranslateBottomSheetViewController?) -> Void) {
        guard childViewControllers.isEmpty else {
            let bottomSheet = childViewControllers.last as! TranslateBottomSheetViewController
            bottomSheet.selectedTextLabel.text = text
            bottomSheet.translatedTextLabel.isHidden = true
            completion(bottomSheet)
            return
        }

        guard let bottomSheet = storyboard?.instantiateViewController(ofClass: TranslateBottomSheetViewController.self) else {
            assertionFailure("Couldn't instantiate UIViewController of type:<\(TranslateBottomSheetViewController.self)>")
            completion(nil)
            return
        }
        
        addChildViewController(bottomSheet)
        view.addSubview(bottomSheet.view)
        bottomSheet.didMove(toParentViewController: self)

        let height = view.frame.height
        let width = view.frame.width
        bottomSheet.view.frame = CGRect(x: 0, y: view.frame.maxY, width: width, height: height)

        bottomSheet.selectedTextLabel.text = text
        completion(bottomSheet)
    }

    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(translateSelected(_:)),
                                               name: .UITranslateSelected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(commentSelected(_:)),
                                               name: .UICommentSelected, object: nil)
    }

    private func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    private func configureUIMenuController() {
        let translateMenuItem = UIMenuItem(title: "Translate", action: #selector(ChatViewController.translateSelected(_:)))
        let commentMenuItem = UIMenuItem(title: "Comment", action: #selector(ChatViewController.commentSelected(_:)))
        UIMenuController.shared.menuItems = [translateMenuItem, commentMenuItem]
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

}
