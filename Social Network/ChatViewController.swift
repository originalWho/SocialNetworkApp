import UIKit

class ChatViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Private properties

    fileprivate var translateService: TranslateService = YandexTranslate()

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        //tabBarController?.tabBar.isHidden = true
        subscribeToNotifications()
        configureUIMenuController()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
    }

    override func viewWillDisappear(_ animated: Bool) {
        //tabBarController?.tabBar.isHidden = false
        unsubscribeFromNotifications()
    }

    var id = [
        "TheirMessageCell",
        "YourMessageCell",
        "YourMessageCell"
    ]

    var messages = [
        "Hello my friend, I expected to see you",
        "What a beautiful day to develop some kind of app!",
        "Imagine all the people\nLiving life in peace\nOhoo hoo"
    ]


}

// MARK: - Public methods

extension ChatViewController {

    // MARK: - Actions

    @IBAction func enableSendButton(_ sender: Any) {
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
    
    @IBAction func sendMessage(_ sender: Any) {
        guard let text = messageTextField.text, !text.isEmpty else {
            return
        }

        messageTextField.text = ""
        sendButton.isEnabled = false
        translateButton.isEnabled = false
        translateButton.imageView?.image = #imageLiteral(resourceName: "Translation-Disabled")

        //guard let vc = storyboard?.instantiateViewController(withIdentifier: "ChatPageViewController") else { return }
        //present(vc, animated: true, completion: nil)
    }

    @IBAction func translateEntered(_ sender: Any) {
        guard let text = messageTextField.text, !text.isEmpty else {
            return
        }

        presentTranslateBottomSheetView(with: text) { [weak self] bottomSheet in
            guard let this = self else {
                return
            }

            this.translateService.translate(text) { translated in
                guard let translated = translated else {
                    bottomSheet?.setTranslated(text: "ERROR: Couldn't translate.")
                    return
                }
                bottomSheet?.setTranslated(text: translated)
            }
        }
    }

    // MARK: - Notifications

    func translateSelected(_ notification: Notification) {
        guard let text = notification.object as? String else {
            return
        }

        presentTranslateBottomSheetView(with: text) { [weak self] bottomSheet in
            guard let this = self else {
                return
            }

            this.translateService.translate(text) { translated in
                guard let translated = translated else {
                    bottomSheet?.setTranslated(text: "ERROR: Couldn't translate.")
                    return
                }
                bottomSheet?.setTranslated(text: translated)
            }
        }
    }

    func commentSelected(_ notification: Notification) {
        guard let text = notification.object as? String else {
            return
        }

        print(text)
    }

    func keyboardWillShow(_ notification: Notification) {
        let keyboardHeight = getKeyboardHeight(notification)
        let offset = getOffset(notification)
        if keyboardHeight == offset {
            self.view.frame.origin.y -= keyboardHeight
        } else {
            self.view.frame.origin.y += keyboardHeight - offset
        }
    }

    func keyboardWillHide(_ notification: Notification) {
        if self.view.frame.origin.y < 0 {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }

}

// MARK: - UITableViewDataSource protocol

extension ChatViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = id.popLast()
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier!) as! MessageTableViewCell
        cell.messageTextView.text = messages.popLast()

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

}

// MARK: - Private methods

fileprivate extension ChatViewController {

    func presentTranslateBottomSheetView(with text: String, completion: @escaping (TranslateBottomSheetViewController?) -> Void) {
        guard childViewControllers.isEmpty else {
            let bottomSheet = childViewControllers.last as! TranslateBottomSheetViewController
            bottomSheet.selectedTextLabel.text = text
            bottomSheet.translatedTextLabel.isHidden = true
            completion(bottomSheet)
            return
        }

        guard let bottomSheet = storyboard?.instantiateViewController(withIdentifier: UIStoryboard.TranslateBottomSheet) as? TranslateBottomSheetViewController else {
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

    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(translateSelected(_:)), name: .UITranslateSelected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(commentSelected(_:)), name: .UICommentSelected, object: nil)
    }

    func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    func configureUIMenuController() {
        let translateMenuItem = UIMenuItem(title: "Translate", action: #selector(ChatViewController.translateSelected(_:)))
        let commentMenuItem = UIMenuItem(title: "Comment", action: #selector(ChatViewController.commentSelected(_:)))
        UIMenuController.shared.menuItems = [translateMenuItem, commentMenuItem]
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }

    func getOffset(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let offset = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return offset.cgRectValue.height
    }

}
