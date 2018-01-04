import UIKit

final class ChatBottomSheetCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    func configure(title: String, description: String?, body: String?, providerName: String?) {
        titleLabel.text = title
        descriptionLabel.text = description
        infoLabel.text = providerName

        if let body = body {
            textView.text = body
            activityIndicator.stopAnimating()
        }
        else {
            textView.text = nil
            activityIndicator.startAnimating()
        }
    }
    
}
