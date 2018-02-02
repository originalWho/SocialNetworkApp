import UIKit

final class DictionaryContextTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    func configure(title: String, text: String?) {
        titleLabel.text = title
        descriptionLabel.text = text
    }

}
