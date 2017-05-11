import UIKit

class ConversationsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
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
