import UIKit

protocol SearchParameterSelectionDelegate: class {
    func searchParameterSelection(_ viewController: SearchParameterSelectionViewController,
                                  didSelectParameter parameter: SearchParameters)
}

final class SearchParameterSelectionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    weak var delegate: SearchParameterSelectionDelegate?
    var parameter: SearchParameters?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationItemTitle()
    }
}

// MARK: - UITableViewDelegate protocol

extension SearchParameterSelectionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            tableView.deselectRow(at: indexPath, animated: true)
        }

        guard let parameter = parameter else { return }

        let previouslySelected: IndexPath
        let selectedParameter: SearchParameters
        let index = indexPath.row

        switch parameter {
        case .country(let previousCountry):
            let selectedCountry = Country(rawValue: index) ?? .none
            selectedParameter = .country(selectedCountry)
            previouslySelected = IndexPath(row: previousCountry.rawValue, section: 0)

        case .gender(let previousGender):
            let selectedGender = Gender(rawValue: index) ?? .none
            selectedParameter = .gender(selectedGender)
            previouslySelected = IndexPath(row: previousGender.rawValue, section: 0)

        case .language(let previousLanguage):
            let languageName = LanguageName(rawValue: index) ?? .none
            let selectedLanguage = Language(with: languageName, and: .none)
            selectedParameter = .language(selectedLanguage)
            previouslySelected = IndexPath(row: previousLanguage.name.rawValue, section: 0)

        case .online, .withPhoto:
            return
        }

        guard indexPath != previouslySelected else { return }

        self.parameter = selectedParameter
        delegate?.searchParameterSelection(self, didSelectParameter: selectedParameter)

        DispatchQueue.main.async {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            tableView.cellForRow(at: previouslySelected)?.accessoryType = .none
        }
    }

}

// MARK: - UITableViewDataSource protocol

extension SearchParameterSelectionViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let parameter = parameter else { return 0 }

        switch parameter {
        case .country:
            return Country.count

        case .gender:
            return Gender.count

        case .language:
            return LanguageName.count

        case .online, .withPhoto:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.SearchParameterSelection)!

        guard let parameter = parameter else { return cell }

        switch parameter {
        case .country(let selectedCountry):
            let country = Country(rawValue: indexPath.row) ?? .none
            cell.textLabel?.text = country.localized
            cell.accessoryType = (country == selectedCountry) ? .checkmark : .none

        case .gender(let selectedGender):
            let gender = Gender(rawValue: indexPath.row) ?? .none
            cell.textLabel?.text = gender.localized
            cell.accessoryType = (gender == selectedGender) ? .checkmark : .none

        case .language(let selectedLanguage):
            let language = LanguageName(rawValue: indexPath.row) ?? .none
            cell.textLabel?.text = language.localized
            cell.accessoryType = (language == selectedLanguage.name) ? .checkmark : .none

        case .online, .withPhoto:
            break
        }

        return cell
    }
    
}

fileprivate extension SearchParameterSelectionViewController {

    func setNavigationItemTitle() {
        navigationItem.backBarButtonItem?.title = "Back"

        guard let parameter = parameter else { return }

        switch parameter {
        case .country:
            navigationItem.title = "Country"

        case .gender:
            navigationItem.title = "Gender"

        case .language:
            navigationItem.title = "Language"

        case .online, .withPhoto:
            navigationItem.title = nil
        }
    }

}
