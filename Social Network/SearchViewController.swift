import UIKit

// MARK: - SearchViewController

final class SearchViewController: UIViewController {

    // MARK: - Private properties

    fileprivate var searchResult: [User]?
    fileprivate let client = SocialNetworkClient.default

    // MARK: - IBOutlets

    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var warningLabel: UILabel!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 110.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(search(_:)), for: .valueChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        search(self)
    }

    // MARK: - Storyboard Segue Preparation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }

        switch identifier {
        case .showEditSearchParameters:
            prepareEditSearchParametersViewController(segue.destination)

        case .showProfileFromSearch:
            prepareProfileViewController(segue.destination, forProfileAt: tableView.indexPathForSelectedRow)

        default:
            return
        }
    }

    private func prepareEditSearchParametersViewController(_ viewController: UIViewController) {
        guard let viewController = viewController as? SearchParametersViewController else {
            return
        }
    }

    private func prepareProfileViewController(_ viewController: UIViewController, forProfileAt indexPath: IndexPath?) {
        guard let viewController = viewController as? ProfileViewController else {
            assertionFailure("Couldn't cast UIViewController to ProfileViewController")
            return
        }

        guard let indexPath = indexPath, let user = searchResult?[indexPath.row] else {
            assertionFailure("Couldn't fetch user from search result")
            return
        }

        viewController.user = user

        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Search

    private typealias ParameterKey = ClientConstants.ParameterKeys
    private typealias QueryKey = ClientConstants.Methods.Search.Key

    @objc private dynamic func search(_ sender: Any?) {
        let query: [String:Any] = [
            QueryKey.count: 20,
            QueryKey.offset: 0
        ]

        let searchParameters = SocialNetworkClient.Settings.searchParameters
        var languages = [String: String]()
        for language in searchParameters.languageNames {
            languages[language.stringValue] = searchParameters.languageLevel.stringValue
        }

        let parameters: [String: Any] = [
            ParameterKey.Country: searchParameters.country.stringValue,
            ParameterKey.Gender: searchParameters.gender.stringValue,
            ParameterKey.Online: searchParameters.online,
            ParameterKey.HasPhoto: searchParameters.withPhoto,
            ParameterKey.Languages: languages
        ]

        client.search(parameters: parameters, query: query) { [weak self] response in
            DispatchQueue.main.async {
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

    // MARK: - UI Updates

    private func updateSearchResults(with users: [User]) {
        tableView.isHidden = false
        warningLabel.isHidden = true
        searchResult = users

        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }

    private func warn(with: ClientConstants.ServerResponse) {
        tableView.isHidden = true
        warningLabel.isHidden = false
        warningLabel.text = "Couldn't Load"
    }

}

// MARK: - UITableViewDataSource protocol

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofClass: SearchTableViewCell.self, for: indexPath)
        let user = searchResult![indexPath.row]
        cell.configure(with: user)
        return cell
    }

}

// MARK: - UIStoryboardSegue identifiers

private extension String {

    static var showEditSearchParameters: String {
        return "showSearchParametersViewController"
    }

    static var showProfileFromSearch: String {
        return "showProfileViewController"
    }

}
