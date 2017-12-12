import UIKit

final class ConversationTableViewCell: UITableViewCell {

    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!

    func configure(name: String, message: String, time: Date, userImage: String? = nil) {
        nameLabel.text = name
        messageLabel.text = message
        userImageView.image = UIImage()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        timeLabel.text = dateFormatter.string(from: time)
    }

}
