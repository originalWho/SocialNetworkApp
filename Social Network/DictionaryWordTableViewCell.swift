import UIKit

final class DictionaryWordTableViewCell: UITableViewCell {

    @IBOutlet private weak var wordLabel: UILabel!
    @IBOutlet private weak var lexicalClassLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(entry: DictionaryEntry) {
        wordLabel.text = entry.value
        lexicalClassLabel.text = entry.lexicalClass.localized
        languageLabel.text = entry.language.localized
    }

}
