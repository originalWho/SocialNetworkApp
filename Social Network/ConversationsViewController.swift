import UIKit

typealias Conversation = (userID: UserID, message: MessageProtocol)

final class ConversationsViewController: UITableViewController {

    private let client = SocialNetworkClient.default
    private var conversations: [Conversation] = MessagesService.default.storage.conversations

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)

        MessagesService.default.subcribe(self)
        MessagesService.default.startListeningToServer()
        // TODO: Unsubscribe
    }

    deinit {
        MessagesService.default.unsubscribe(self)
    }

    // MARK: - Storyboard Segue Preparation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }

        switch identifier {
        case .showChatViewController:
            prepareChatViewController(segue.destination, forConversationAt: tableView.indexPathForSelectedRow)

        default:
            return
        }
    }

    private func prepareChatViewController(_ viewController: UIViewController, forConversationAt indexPath: IndexPath?) {
        guard let viewController = viewController as? ChatViewController else {
            assertionFailure("Couldn't cast UIViewController to ChatViewController")
            return
        }

        guard let indexPath = indexPath else {
            assertionFailure("Couldn't fetch conversation")
            return
        }

        viewController.userID = conversations[indexPath.row].userID
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - UITableViewDataSource protocol

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofClass: ConversationTableViewCell.self, for: indexPath)
        let conversation = conversations[indexPath.row]
        cell.configure(userID: conversation.userID, message: conversation.message)
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }

    // MARK: - UI Updates

    @objc private dynamic func refresh(_ sender: Any) {
//        DispatchQueue.global(qos: .userInitiated).async {
//            MessagesService.default.fetchConversations { conversations in
//                DispatchQueue.main.async { [weak self] in
//                    self?.tableView.refreshControl?.endRefreshing()
//
//                    guard let `self` = self, let conversations = conversations else { return }
//                    self.conversations = conversations
//                    self.tableView.reloadData()
//                }
//            }
//        }
    }

}

extension ConversationsViewController: MessagesServiceObserver {

    func onUpdate(service: MessagesService) {
        DispatchQueue.main.async { [weak self] in
            self?.conversations = service.storage.conversations
            self?.tableView.reloadData()
        }
    }

    func onUpdate(from userID: UserID, service: MessagesService) {

    }

}

// MARK: - Storyboard Segue Identifiers

private extension String {

    static var showChatViewController: String {
        return "showChatViewController"
    }

}
