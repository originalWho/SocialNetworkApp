import UIKit

final class SearchParameterTableViewCell: UITableViewCell {

    @IBOutlet weak var parameterLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with parameter: SearchParameters) {
        switch parameter {
        case .country(let country):
            parameterLabel.text = "Country"
            valueLabel.text = country.localized

        case .language(let language):
            parameterLabel.text = language.name.localized
            valueLabel.text = language.level.localized

        case .gender(let gender):
            parameterLabel.text = "Gender"
            valueLabel.text = gender.localized

        case .online(let isOnline):
            parameterLabel.text = "Online"
            
            valueLabel.text = nil
            accessoryType = (isOnline) ? .checkmark : .none

        case .withPhoto(let isWithPhoto):
            parameterLabel.text = "With Photo"
            valueLabel.text = nil
            accessoryType = (isWithPhoto) ? .checkmark : .none
        }
    }

}
