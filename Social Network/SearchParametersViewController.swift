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

    fileprivate var searchParameters: SearchParameters!
    fileprivate var generalParameters: [GeneralSectionCellType]!

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
                
            case .countries, .gender, .languages:
                break
            }
            
            cell?.accessoryType = isSelected ? .none : .checkmark
            tableView.reloadRows(at: [indexPath], with: .fade)
            
        case .disclosure(let parameter):
            pushParameterSelectionViewController(for: parameter)
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
        return generalParameters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchParameterTableViewCell
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

// MARK: - Private methods

fileprivate extension SearchParametersViewController {

    func pushParameterSelectionViewController(for parameter: SearchParameter) {
        guard let viewController = storyboard?
            .instantiateViewController(withIdentifier: UIStoryboard.SearchParameterSelection)
            as? SearchParameterSelectionViewController else { return }

        viewController.delegate = self
        viewController.parameter = parameter
        navigationController?.pushViewController(viewController, animated: true)
    }

}
