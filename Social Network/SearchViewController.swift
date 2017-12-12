import UIKit

// MARK: - SearchViewController

final class SearchViewController: UIViewController {

    // MARK: - Private properties

    fileprivate var searchResult: [User]?
    fileprivate let client = SocialNetworkClient.default

    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var warningLabel: UILabel!

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        let rightBarButton = UIBarButtonItem(title: "Edit",
                                             style: .plain,
                                             target: self,
                                             action: #selector(showSearchParameters(_:)))
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        tableView.estimatedRowHeight = 110.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(search(_:)), for: .valueChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        search()
    }

    func showSearchParameters(_ sender: Any) {
        guard let searchParametersViewController = storyboard?
            .instantiateViewController(withIdentifier: UIStoryboard.SearchParameters) else {
                return
        }

        navigationController?.pushViewController(searchParametersViewController, animated: true)
    }

}

// MARK: - Public methods

extension SearchViewController {

    private typealias ParameterKey = ClientConstants.ParameterKeys
    private typealias QueryKey = ClientConstants.Methods.Search.Key

    func search(_ sender: Any? = nil) {
        let query: [String:Any] = [
            QueryKey.Count: 20,
            QueryKey.Offset: 0
        ]

        let parameters: [String:Any] = [
            ParameterKey.Languages: [
                LanguageName.tatar.stringValue: LanguageLevel.native.stringValue
            ]
        ]

        client.search(parameters: parameters, query: query) { [weak self] response in
            guard let this = self else {
                return
            }

            switch response {
            case .fail(let response):
                this.warn(with: response)

            case .success(let users):
                this.updateSearchResults(with: users)
            }
        }
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
        tableView.deselectRow(at: indexPath, animated: true)
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

    func updateSearchResults(with users: [User]) {
        tableView.isHidden = false
        warningLabel.isHidden = true
        searchResult = users
        DispatchQueue.main.async { [weak self] in
            guard let this = self else {
                return
            }
            
            this.tableView.reloadData()
            this.tableView.refreshControl?.endRefreshing()
        }

    }

    func warn(with: ClientConstants.ServerResponse) {
        tableView.isHidden = true
        warningLabel.isHidden = false
        warningLabel.text = "Couldn't Load"
    }

}
