import UIKit

final class MessageTableViewCell: UITableViewCell {

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter
    }()

    var position: Int {
        get {
            return messageTextView.tag
        }
        set {
            messageTextView.tag = newValue
        }
    }

    @IBOutlet private weak var messageTextView: UITextView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var commentImageView: UIImageView!

    func configure(message: MessageProtocol, comments: [CommentProtocol]?, commentsHidden: Bool) {
        switch message.dataType {
        case .text:
            if let text = String(data: message.data, encoding: .utf16) {
                let textColor: UIColor = (SocialNetworkClient.Settings.userId == message.senderID) ? .white : .black
                messageTextView.attributedText = prepare(text: text,
                                                         ofColor: textColor,
                                                         comments: comments,
                                                         commentsHidden: commentsHidden)
            }

        case .audio, .image:
            messageTextView.text = "Unsuppoted"
        }

        timeLabel.text = MessageTableViewCell.dateFormatter.string(from: message.date)

        if let comments = comments, !comments.isEmpty {
            commentImageView.alpha = 1.0
        }
        else {
            commentImageView.alpha = 0.0
        }
        commentImageView.isHighlighted = !commentsHidden
    }

    private func prepare(text: String, ofColor textColor: UIColor, comments: [CommentProtocol]?, commentsHidden: Bool) -> NSAttributedString? {
        let attributedText = NSMutableAttributedString(string: text, attributes: [
            .font : UIFont.systemFont(ofSize: 17.0, weight: .regular),
            .foregroundColor : textColor]
        )

        guard !commentsHidden, let comments = comments?.sorted(by: { $0.startPosition < $1.startPosition }) else {
            return attributedText
        }

        var offset = 0

        let commentColor: UIColor = (textColor == .white)
            ? UIColor(red: 229.0 / 255.0, green: 229.0 / 255.0, blue: 229.0 / 255.0, alpha: 1.0)
            : UIColor(red: 50.0 / 255.0, green: 166.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)

        for comment in comments {
            guard let commentText = String(data: comment.data, encoding: .utf16) else { continue }
            let attributedCommentText = NSAttributedString(string: " \(commentText) ", attributes: [
                .font : UIFont.systemFont(ofSize: 17.0, weight: .medium),
                .foregroundColor : commentColor]
            )

            attributedText.insert(attributedCommentText, at: comment.endPosition + offset)

            offset += attributedCommentText.length
        }

        return attributedText
    }

}
