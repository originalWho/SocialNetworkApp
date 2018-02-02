import UIKit

protocol SearchParameterSelectionDelegate: class {

    func searchParameterSelection(_ viewController: SearchParameterSelectionViewController,
                                  didSelectParameter parameter: SearchParameterSelectionViewController.Parameter)

}

final class SearchParameterSelectionViewController: UIViewController {

    enum Parameter {
        case none
        case country(Country)
        case languageNames([LanguageName])
        case gender(Gender)
    }

    @IBOutlet private weak var tableView: UITableView!

    weak var delegate: SearchParameterSelectionDelegate?
    var parameter: Parameter = .none

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationItemTitle()
    }

    // MARK: - UI Configuration
    
    private func setNavigationItemTitle() {
        navigationItem.backBarButtonItem?.title = "Back"

        switch parameter {
        case .none:
            navigationItem.title = nil

        case .country:
            navigationItem.title = "Country"

        case .gender:
            navigationItem.title = "Gender"

        case .languageNames:
            navigationItem.title = "Languages"
        }
    }

}

// MARK: - UITableViewDelegate protocol

extension SearchParameterSelectionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        var indexPathsToReload = [IndexPath]()

        switch parameter {
        case .none:
            return

        case let .country(country):
            if let newCountry = Country(rawValue: indexPath.row) {
                parameter = .country(newCountry)
                indexPathsToReload.append(IndexPath(row: country.rawValue, section: 0))
                indexPathsToReload.append(IndexPath(row: newCountry.rawValue, section: 0))
            }

        case let .languageNames(languageNames):
            if let languageName = LanguageName(rawValue: indexPath.row) {
                if languageName == .none {
                    for language in languageNames {
                        indexPathsToReload.append(IndexPath(row: language.rawValue, section: 0))
                    }
                    parameter = .languageNames([languageName])
                }
                else if languageNames.contains(languageName) {
                    parameter = .languageNames(languageNames.filter { $0 != languageName })
                }
                else {
                    var languageNames = languageNames
                    languageNames.append(languageName)
                    if languageNames.contains(.none) {
                        indexPathsToReload.append(IndexPath(row: LanguageName.none.rawValue, section: 0))
                    }
                    parameter = .languageNames(languageNames.filter { $0 != .none })
                }
                indexPathsToReload.append(IndexPath(row: languageName.rawValue, section: 0))
            }

        case let .gender(gender):
            if let newGender = Gender(rawValue: indexPath.row) {
                parameter = .gender(newGender)
                indexPathsToReload.append(IndexPath(row: gender.rawValue, section: 0))
                indexPathsToReload.append(IndexPath(row: newGender.rawValue, section: 0))
            }
        }

        tableView.beginUpdates()
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
        tableView.endUpdates()

        delegate?.searchParameterSelection(self, didSelectParameter: parameter)
    }

}

// MARK: - UITableViewDataSource protocol

extension SearchParameterSelectionViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch parameter {
        case .none:
            return 0

        case .country:
            return Country.count

        case .gender:
            return Gender.count

        case .languageNames:
            return LanguageName.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofClass: UITableViewCell.self, for: indexPath)

        switch parameter {
        case .none:
            break

        case let .country(selectedCountry):
            if let country = Country(rawValue: indexPath.row) {
                cell.textLabel?.text = country.localized
                cell.accessoryType = (selectedCountry == country) ? .checkmark : .none
            }

        case let .gender(selectedGender):
            if let gender = Gender(rawValue: indexPath.row) {
                cell.textLabel?.text = gender.localized
                cell.accessoryType = (selectedGender == gender) ? .checkmark : .none
            }

        case let .languageNames(languageNames):
            if let languageName = LanguageName(rawValue: indexPath.row) {
                cell.textLabel?.text = languageName.localized
                cell.accessoryType = languageNames.contains(languageName) ? .checkmark : .none
            }
        }

        return cell
    }
    
}
