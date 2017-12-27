import UIKit

// MARK: - SearchParameters enum

enum SearchParameter {
    case languages([Language])
    case countries([Country])
    case gender(Gender)
    case online(Bool)
    case withPhoto(Bool)
}

struct SearchParameters {
    var languages: [Language]
    var countries: [Country]
    var gender: Gender
    var online: Bool
    var withPhoto: Bool

    init(languages: [Language] = [Language(with: .none, and: .none)], countries: [Country] = [.none],
         gender: Gender = .none, online: Bool = true, withPhoto: Bool = true) {
        self.languages = languages
        self.countries = countries
        self.gender = gender
        self.online = online
        self.withPhoto = withPhoto
    }
}

// MARK: - SearchParametersViewController

final class SearchParametersViewController: UIViewController {

    // MARK: - Private types

    fileprivate enum GeneralSectionCellType {
        case checkmark(SearchParameter)
        case disclosure(SearchParameter)
    }

    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Private properties

    fileprivate var searchParameters: SearchParameters?
    fileprivate var generalParameters: [GeneralSectionCellType]?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

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

        guard let indexPath = indexPath, let type = generalParameters?[indexPath.row] else {
            return
        }

        switch type {
        case let .disclosure(parameter):
            viewController.parameter = parameter

        case .checkmark:
            return
        }

        viewController.delegate = self
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - UITableViewDelegate protocol

extension SearchParametersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = generalParameters?[indexPath.row] else {
            return
        }

        switch type {
        case .checkmark(let parameter):
            let cell = tableView.cellForRow(at: indexPath)
            let isSelected = (cell?.accessoryType == .checkmark)
            
            switch parameter {
            case .online:
                generalParameters?[indexPath.row] = .checkmark(.online(!isSelected))
                
            case .withPhoto:
                generalParameters?[indexPath.row] = .checkmark(.withPhoto(!isSelected))
                
            case .countries, .gender, .languages:
                break
            }
            
            cell?.accessoryType = isSelected ? .none : .checkmark
            tableView.reloadRows(at: [indexPath], with: .fade)
            
        case .disclosure:
            return
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: - UITableViewDataSource protocol

extension SearchParametersViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "General"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generalParameters?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = generalParameters?[indexPath.row] else {
            assertionFailure("Couldn't fetch cell type from general parameters at indexPath:<\(indexPath)>")
            return UITableViewCell()
        }

        let cell: UITableViewCell

        switch type {
        case .checkmark(let parameter):
            cell = tableView.dequeueReusableCell(withIdentifier: .checkmarkTableViewCellIdentifier, for: indexPath)
            if let cell = cell as? SearchParameterTableViewCell {
                cell.configure(with: parameter)
            }

        case .disclosure(let parameter):
            cell = tableView.dequeueReusableCell(withIdentifier: .disclosureTableViewCellIdentifier, for: indexPath)
            if let cell = cell as? SearchParameterTableViewCell {
                cell.configure(with: parameter)
            }
        }

        return cell
    }

}

// MARK: - SearchParameterSelectionDelegate protocol

extension SearchParametersViewController: SearchParameterSelectionDelegate {

    func searchParameterSelection(_ viewController: SearchParameterSelectionViewController,
                                  didSelectParameter parameter: SearchParameter) {
        print(parameter)
    }

}

// MARK: - Storyboard Segue Identifiers

private extension String {

    static var showEditSingleSearchParameter: String {
        return "showEditSingleSearchParameter"
    }

    static var disclosureTableViewCellIdentifier: String {
        return "SearchParameterDisclosureTableViewCell"
    }

    static var checkmarkTableViewCellIdentifier: String {
        return "SearchParameterCheckmarkTableViewCell"
    }

}
