import UIKit

final class MessageTableViewCell: UITableViewCell {

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter
    }()

    @IBOutlet private weak var messageTextView: UITextView!
    @IBOutlet private weak var timeLabel: UILabel!

    func configure(message: Message) {
        switch message.dataType {
        case .text:
            messageTextView.text = String(data: message.data, encoding: .utf16)

        case .audio, .image:
            messageTextView.text = "Unsuppoted"
        }

        timeLabel.text = MessageTableViewCell.dateFormatter.string(from: message.date)
    }

}
