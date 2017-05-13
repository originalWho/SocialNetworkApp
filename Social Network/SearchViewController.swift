import UIKit

class SearchViewController: UIViewController {

    // MARK: - Private properties

    fileprivate var searchResult: [User]?
    fileprivate let client = SocialNetworkClient.default

    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        let rightBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(showSearchParameters(_:)))
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        search()
    }

    func showSearchParameters(_ sender: Any) {
        print("edit")
    }

}

// MARK: - UITableViewDelegate protocol

extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = searchResult?[indexPath.row] else {
            return
        }

        let profileViewController = storyboard?.instantiateViewController(withIdentifier: UIStoryboard.Profile) as! ProfileViewController
        profileViewController.user = user
        navigationController?.pushViewController(profileViewController, animated: true)
    }

}

// MARK: - UITableViewDataSource protocol

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.Search) as! SearchTableViewCell
        let user = searchResult![indexPath.row]
        cell.configure(with: user)

        return cell
    }

}

// MARK: - Private methods

fileprivate extension SearchViewController {

    private typealias QueryKey = SocialNetworkClient.ParameterKeys
    private typealias ParameterKey = SocialNetworkClient.Methods.Search.Key

    func search() {
        let parameters: [String:Any] = [
            ParameterKey.Count: 20,
            ParameterKey.Offset: 0
        ]

        let query: [String:Any] = [
            QueryKey.Languages: [
                LanguageName.English.stringValue: LanguageLevel.Native.stringValue
            ]
        ]

        client.search(parameters: parameters, query: query) { response in
            
        }
    }

}
