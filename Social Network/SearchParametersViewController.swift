import UIKit

// MARK: - SearchParameters enum

enum SearchParameters {
    case language(Language)
    case country(Country)
    case gender(Gender)
    case online(Bool)
    case withPhoto(Bool)
}

// MARK: - SearchParametersViewController

final class SearchParametersViewController: UIViewController {

    // MARK: - Public types

//    struct Query {
//
//    }

    // MARK: - Private types

    fileprivate enum ParameterSection {
        case general
        case languages

        var titleForHeader: String {
            switch self {
            case .general:
                return "General"

            case .languages:
                return "Languages"
            }
        }
    }

    fileprivate enum GeneralSectionCellType {
        case checkmark(SearchParameters)
        case disclosure(SearchParameters)
    }

    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Private properties

    fileprivate let parametersSections: [ParameterSection] = [
        .general, .languages
    ]

    fileprivate var generalParameters: [GeneralSectionCellType] = [
        .disclosure(.country(.none)),
        .disclosure(.gender(.none)),
        .checkmark(.online(true)),
        .checkmark(.withPhoto(true))
    ]

    fileprivate var languages: [Language] = [
        Language(with: .none, and: .none)
    ]

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Search Parameters"
    }
    
}

// MARK: - UITableViewDelegate protocol

extension SearchParametersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = parametersSections[indexPath.section]

        switch section {
        case .general:
            let type = generalParameters[indexPath.row]

            switch type {
            case .checkmark(let parameter):
                let cell = tableView.cellForRow(at: indexPath)
                let isSelected = (cell?.accessoryType == .checkmark)

                switch parameter {
                case .online:
                    generalParameters[indexPath.row] = .checkmark(.online(!isSelected))

                case .withPhoto:
                    generalParameters[indexPath.row] = .checkmark(.withPhoto(!isSelected))

                case .country, .gender, .language:
                    break
                }

                DispatchQueue.main.async {
                    cell?.accessoryType = isSelected ? .none : .checkmark
                    tableView.reloadRows(at: [indexPath], with: .fade)
                }

            case .disclosure(let parameter):
                pushParameterSelectionViewController(for: parameter)
            }

        case .languages:
            let language = languages[indexPath.row]
            pushParameterSelectionViewController(for: .language(language))
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: - UITableViewDataSource protocol

extension SearchParametersViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return parametersSections[section].titleForHeader
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return parametersSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = parametersSections[section]

        switch section {
        case .general:
            return generalParameters.count

        case .languages:
            return languages.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchParameterTableViewCell
        let section = parametersSections[indexPath.section]

        switch section {
        case .general:
            let type = generalParameters[indexPath.row]
            
            switch type {
            case .checkmark(let parameter):
                cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.SearchParameterCheckmark)
                    as! SearchParameterTableViewCell
                cell.configure(with: parameter)

            case .disclosure(let parameter):
                cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.SearchParameterDisclosure)
                    as! SearchParameterTableViewCell
                cell.configure(with: parameter)
            }

        case .languages:
            let language = languages[indexPath.row]
            cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.SearchParameterDisclosure)
                as! SearchParameterTableViewCell
            cell.configure(with: .language(language))
        }

        return cell
    }

}

// MARK: - SearchParameterSelectionDelegate protocol

extension SearchParametersViewController: SearchParameterSelectionDelegate {

    func searchParameterSelection(_ viewController: SearchParameterSelectionViewController,
                                  didSelectParameter parameter: SearchParameters) {
        print(parameter)
    }

}

// MARK: - Private methods

fileprivate extension SearchParametersViewController {

    func pushParameterSelectionViewController(for parameter: SearchParameters) {
        guard let viewController = storyboard?
            .instantiateViewController(withIdentifier: UIStoryboard.SearchParameterSelection)
            as? SearchParameterSelectionViewController else { return }

        viewController.delegate = self
        viewController.parameter = parameter
        navigationController?.pushViewController(viewController, animated: true)
    }

}
