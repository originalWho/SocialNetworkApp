import UIKit

final class MessageTableViewCell: UITableViewCell {

    @IBOutlet private weak var messageTextView: UITextView!

    func configure(message: String?) {
        messageTextView.text = message
    }

}
