import UIKit

// MARK: - SearchParameters enum

struct SearchParameters {
    var languageNames: [LanguageName]
    var languageLevel: LanguageLevel
    var country: Country
    var gender: Gender
    var online: Bool
    var withPhoto: Bool

    init(languages: [LanguageName] = [], languageLevel: LanguageLevel = .none, country: Country = .none,
         gender: Gender = .none, online: Bool = true, withPhoto: Bool = true) {
        self.languageNames = languages
        self.languageLevel = languageLevel
        self.country = country
        self.gender = gender
        self.online = online
        self.withPhoto = withPhoto
    }
}

// MARK: - SearchParametersViewController

final class SearchParametersViewController: UIViewController {

    // MARK: - Private types

    private enum Row: Int {
        case languages
        case country
        case gender
        case isOnline
        case withPhoto
        case isFluent
    }

    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Private properties

    private var searchParameters = SocialNetworkClient.Settings.searchParameters
    private let rows: [Row] = [.languages, .country, .gender, .isOnline, .withPhoto, .isFluent]

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Search Parameters"
    }

    // MARK: - Storyboard Segue Preparation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }

        switch identifier {
        case .showEditSingleSearchParameter:
            prepareSearchParameterSelectionViewController(segue.destination, forParameterAt: tableView.indexPathForSelectedRow)

        default:
            return
        }
    }

    private func prepareSearchParameterSelectionViewController(_ viewController: UIViewController, forParameterAt indexPath: IndexPath?) {
        guard let viewController = viewController as? SearchParameterSelectionViewController else {
            assertionFailure("Couldn't cast UIViewController to SearchParameterSelectionViewController")
            return
        }

        guard let indexPath = indexPath, let row = Row(rawValue: indexPath.row) else {
            return
        }

        switch row {
        case .languages:
            viewController.parameter = .languageNames(searchParameters.languageNames)

        case .country:
            viewController.parameter = .country(searchParameters.country)

        case .gender:
            viewController.parameter = .gender(searchParameters.gender)

        case .isOnline, .withPhoto, .isFluent:
            return
        }

        viewController.delegate = self
    }
    
}

// MARK: - UITableViewDelegate protocol

extension SearchParametersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = Row(rawValue: indexPath.row) else {
            return
        }

        switch row {
        case .isOnline:
            searchParameters.online = !searchParameters.online

        case .withPhoto:
            searchParameters.withPhoto = !searchParameters.withPhoto

        case .isFluent:
            searchParameters.languageLevel = (searchParameters.languageLevel == .none)
                ? .fluent
                : .none

        case .country, .gender, .languages:
            performSegue(withIdentifier: .showEditSingleSearchParameter, sender: self)
        }

        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.deselectRow(at: indexPath, animated: true)

        SocialNetworkClient.Settings.searchParameters = searchParameters
    }

}

// MARK: - UITableViewDataSource protocol

extension SearchParametersViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "General"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = Row.init(rawValue: indexPath.row) else {
            assertionFailure()
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(ofClass: SearchParameterTableViewCell.self, for: indexPath)

        switch row {
        case .country:
            cell.configure(country: searchParameters.country)

        case .languages:
            cell.configure(languages: searchParameters.languageNames)

        case .gender:
            cell.configure(gender: searchParameters.gender)

        case .isOnline:
            cell.configure(title: "Online", isChecked: searchParameters.online)

        case .withPhoto:
            cell.configure(title: "With Photo", isChecked: searchParameters.withPhoto)

        case .isFluent:
            cell.configure(title: "Fluent Only", isChecked: searchParameters.languageLevel == .fluent)
        }

        return cell
    }

}

// MARK: - SearchParameterSelectionDelegate protocol

extension SearchParametersViewController: SearchParameterSelectionDelegate {

    func searchParameterSelection(_ viewController: SearchParameterSelectionViewController,
                                  didSelectParameter parameter: SearchParameterSelectionViewController.Parameter) {
        switch parameter {
        case .none:
            return

        case let .country(country):
            searchParameters.country = country

        case let .gender(gender):
            searchParameters.gender = gender

        case let .languageNames(languageNames):
            searchParameters.languageNames = languageNames
        }

        tableView.reloadData()
        SocialNetworkClient.Settings.searchParameters = searchParameters
    }

}

// MARK: - Storyboard Segue Identifiers

private extension String {

    static var showEditSingleSearchParameter: String {
        return "showSearchParameterSelectionViewController"
    }

}
