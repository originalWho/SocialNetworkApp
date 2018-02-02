import UIKit

final class SearchParameterTableViewCell: UITableViewCell {

    @IBOutlet private weak var parameterLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!

    func configure(country: Country) {
        parameterLabel.text = "Country"
        valueLabel.text = country.localized
        accessoryType = .disclosureIndicator
    }

    func configure(languages: [LanguageName]) {
        parameterLabel.text = "Languages"
        if languages.isEmpty {
            valueLabel.text = "None"
        }
        else if languages.count == 1 {
            valueLabel.text = languages.first?.localized
        }
        else {
            valueLabel.text = "\(languages.count) languages"
        }
        accessoryType = .disclosureIndicator
    }

    func configure(gender: Gender) {
        parameterLabel.text = "Gender"
        valueLabel.text = gender.localized
        accessoryType = .disclosureIndicator
    }

    func configure(title: String, isChecked: Bool) {
        parameterLabel.text = title
        valueLabel.text = nil
        accessoryType = isChecked ? .checkmark : .none
    }

}
