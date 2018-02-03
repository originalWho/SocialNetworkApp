import UIKit

final class ConversationTableViewCell: UITableViewCell {

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter
    }()

    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!

    func configure(user: User, message: Message) {
        nameLabel.text = user.name
        
        switch message.dataType {
        case .text:
            messageLabel.text = String(data: message.data, encoding: .utf16)

        case .audio:
            messageLabel.text = "🔈 Audio"

        case .image:
            messageLabel.text = "🖼 Image"
        }

        timeLabel.text = ConversationTableViewCell.dateFormatter.string(from: message.date)
    }

}
