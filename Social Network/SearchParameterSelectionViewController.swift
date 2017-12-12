import UIKit

protocol SearchParameterSelectionDelegate: class {
    func searchParameterSelection(_ viewController: SearchParameterSelectionViewController,
                                  didSelectParameter parameter: SearchParameter)
}

final class SearchParameterSelectionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    weak var delegate: SearchParameterSelectionDelegate?
    var parameter: SearchParameter?

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
        tableView.deselectRow(at: indexPath, animated: true)

        guard let parameter = parameter else { return }

        var previouslySelected: IndexPath?
        let selectedParameter: SearchParameter
        let index = indexPath.row

        switch parameter {
        case .countries(var countries):
            let selectedCountry = Country(rawValue: index) ?? .none
            if let selectedCountryIndex = countries.index(where: { $0.rawValue == selectedCountry.rawValue }) {
                countries.remove(at: selectedCountryIndex)
                previouslySelected = IndexPath(row: selectedCountry.rawValue, section: 0)
            }
            else {
                countries.append(selectedCountry)
            }
            selectedParameter = .countries(countries)

        case .gender(let gender):
            let selectedGender = Gender(rawValue: index) ?? .none
            selectedParameter = .gender(selectedGender)
            previouslySelected = IndexPath(row: gender.rawValue, section: 0)

        case .languages(var languages):
            let languageName = LanguageName(rawValue: index) ?? .none
            let selectedLanguage = Language(with: languageName, and: .none)
            if let selectedLanguageIndex = languages.index(where: { $0.name.rawValue == selectedLanguage.name.rawValue }) {
                languages.remove(at: selectedLanguageIndex)
                previouslySelected = IndexPath(row: selectedLanguage.name.rawValue, section: 0)
            }
            else {
                languages.append(selectedLanguage)
            }
            selectedParameter = .languages(languages)


        case .online, .withPhoto:
            return
        }

        self.parameter = selectedParameter
        delegate?.searchParameterSelection(self, didSelectParameter: selectedParameter)

        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        if let previouslySelected = previouslySelected {
            tableView.cellForRow(at: previouslySelected)?.accessoryType = .none
        }
    }

}

// MARK: - UITableViewDataSource protocol

extension SearchParameterSelectionViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let parameter = parameter else { return 0 }

        switch parameter {
        case .countries:
            return Country.count

        case .gender:
            return Gender.count

        case .languages:
            return LanguageName.count

        case .online, .withPhoto:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.SearchParameterSelection, for: indexPath)

        guard let parameter = parameter else { return cell }

        switch parameter {
        case .countries(let selectedCountries):
            let country = Country(rawValue: indexPath.row) ?? .none
            cell.textLabel?.text = country.localized
            cell.accessoryType = selectedCountries.contains(where: { $0 == country }) ? .checkmark : .none

        case .gender(let selectedGender):
            let gender = Gender(rawValue: indexPath.row) ?? .none
            cell.textLabel?.text = gender.localized
            cell.accessoryType = (gender == selectedGender) ? .checkmark : .none

        case .languages(let selectedLanguages):
            let language = LanguageName(rawValue: indexPath.row) ?? .none
            cell.textLabel?.text = language.localized
            cell.accessoryType = selectedLanguages.contains(where: { $0.name == language }) ? .checkmark : .none

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
        case .countries:
            navigationItem.title = "Country"

        case .gender:
            navigationItem.title = "Gender"

        case .languages:
            navigationItem.title = "Language"

        case .online, .withPhoto:
            navigationItem.title = nil
        }
    }

}
