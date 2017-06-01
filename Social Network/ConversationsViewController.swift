import UIKit

final class ConversationsViewController: UITableViewController {

    let client = SocialNetworkClient.default

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)

        client.receive(.all) { request in
            print("S")
        }
    }

}

extension ConversationsViewController {

    func refresh(_ sender: Any) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }

}

extension ConversationsViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: UIStoryboard.Chat)
        let cell = tableView.cellForRow(at: indexPath) as! ConversationTableViewCell
        vc?.navigationItem.title = cell.nameLabel.text
        navigationController?.pushViewController(vc!, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationTableViewCell") as! ConversationTableViewCell
        cell.configure(name: "Friend", message: "What's up mate?", time: Date())

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

}
