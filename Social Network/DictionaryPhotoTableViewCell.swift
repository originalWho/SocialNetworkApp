import UIKit

final class DictionaryPhotoTableViewCell: UITableViewCell {

    @IBOutlet private weak var entryImageView: UIImageView!
    
    func configure(image: UIImage?) {
        entryImageView.image = image
    }

}
