import UIKit

class ChatViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var sendButton: UIButton!
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
            return
        }

        sendButton.isEnabled = true
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        guard let text = messageTextField.text, !text.isEmpty else {
            return
        }

        messageTextField.text = ""
        sendButton.isEnabled = false
    }

    // MARK: - Notifications

    func translateSelected(_ notification: Notification) {
        guard let text = notification.object as? String else {
            return
        }

        translateService.translate(text) { translated in
            guard let translated = translated else {
                print("FAIL")
                return
            }
            
            print(translated)
        }
        
        /*
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = vc.view.frame
        vc.view.insertSubview(blurEffectView, at: 0)
        present(vc, animated: true, completion: nil)
        vc.dismiss(animated: true, completion: nil)
        print(text)
         */
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
