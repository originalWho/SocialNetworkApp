import UIKit

class ConversationTableViewCell: UITableViewCell {


    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    func configure(name: String, message: String, time: Date, userImage: String? = nil) {
        nameLabel.text = name
        messageLabel.text = message
        userImageView.image = UIImage()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        timeLabel.text = dateFormatter.string(from: time)
    }

}
