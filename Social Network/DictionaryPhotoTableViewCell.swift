import UIKit

final class DictionaryPhotoTableViewCell: UITableViewCell {

    @IBOutlet private weak var entryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(image: UIImage?) {
        entryImageView.image = image
    }

}
