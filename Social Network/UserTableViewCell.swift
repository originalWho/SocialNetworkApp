import UIKit

final class UserTableViewCell: UITableViewCell {

    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userCountryLabel: UILabel!

    func configure(user: User) {
        userNameLabel.text = user.name
        userCountryLabel.text = user.country?.localized
    }

}
