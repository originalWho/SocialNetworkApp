import UIKit

final class DictionaryEntryTableViewCell: UITableViewCell {

    @IBOutlet private weak var wordLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var contextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(entry: DictionaryEntry) {
        wordLabel.text = entry.value
        languageLabel.text = entry.language.localized
        contextLabel.text = entry.context
    }

}
