import UIKit

final class UserListTableViewController: UITableViewController {

    enum List {
        case none
        case subsribers
        case subscribtions
    }

    private var list: List = .none
    private var users: [User] = []

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        switch identifier {
        case .showProfile:
            prepareProfileViewController(segue.destination)

        default:
            return
        }
    }

    func configure(with users: [User], for list: List) {
        self.list = list
        self.users = users
    }

    private func prepareProfileViewController(_ viewController: UIViewController) {
        guard let viewController = viewController as? ProfileViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
                return
        }

        viewController.userID = users[indexPath.row].id
        tableView.deselectRow(at: indexPath, animated: true)
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofClass: UserTableViewCell.self, for: indexPath)
        cell.configure(user: users[indexPath.row])
        return cell
    }
    
}

private extension String {

    static var showProfile: String {
        return "showProfile"
    }

}
