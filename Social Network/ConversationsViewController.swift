import UIKit

final class ConversationsViewController: UITableViewController {

    private let client = SocialNetworkClient.default
    private var conversations: [Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)

        client.receive(.all, from: nil) { request in

        }
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

        guard let indexPath = indexPath, let conversation = conversations?[indexPath.row] else {
//            assertionFailure("Couldn't fetch conversation")
            return
        }

        // TODO: Inject conversation meta data
        tableView.deselectRow(at: indexPath, animated: true)
    }


    // MARK: - UITableViewDelegate protocol

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: ChatViewController.id)
//        let cell = tableView.cellForRow(at: indexPath) as! ConversationTableViewCell
//        vc?.navigationItem.title = cell.nameLabel.text
//        navigationController?.pushViewController(vc!, animated: true)
    }

    // MARK: - UITableViewDataSource protocol

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofClass: ConversationTableViewCell.self, for: indexPath)
        cell.configure(name: "Friend", message: "What's up mate?", time: Date())
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    // MARK: - UI Updates

    private dynamic func refresh(_ sender: Any) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }

}

// MARK: - Storyboard Segue Identifiers

private extension String {

    static var showChatViewController: String {
        return "showChatViewController"
    }

}
