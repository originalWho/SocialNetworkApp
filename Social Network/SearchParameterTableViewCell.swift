import UIKit

final class SearchParameterTableViewCell: UITableViewCell {

    @IBOutlet private weak var parameterLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!

    func configure(with parameter: SearchParameter) {
        switch parameter {
        case .countries(let countries):
            parameterLabel.text = "Countries"
            if countries.isEmpty {
                valueLabel.text = "None"
            }
            else if countries.count == 1 {
                valueLabel.text = countries.first?.localized
            }
            else {
                valueLabel.text = "\(countries.count) countries"
            }

        case .languages(let languages):
            parameterLabel.text = "Languages"
            if languages.isEmpty {
                valueLabel.text = "None"
            }
            else if languages.count == 1 {
                valueLabel.text = languages.first?.name.localized
            }
            else {
                valueLabel.text = "\(languages.count) countries"
            }

        case .gender(let gender):
            parameterLabel.text = "Gender"
            valueLabel.text = gender.localized

        case .online(let isOnline):
            parameterLabel.text = "Online"
            
            valueLabel.text = nil
            accessoryType = isOnline ? .checkmark : .none

        case .withPhoto(let isWithPhoto):
            parameterLabel.text = "With Photo"
            valueLabel.text = nil
            accessoryType = isWithPhoto ? .checkmark : .none
        }
    }

}
