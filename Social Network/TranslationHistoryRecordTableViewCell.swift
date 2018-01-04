import UIKit

final class TranslationHistoryRecordTableViewCell: UITableViewCell {

    @IBOutlet private weak var translatedWordLabel: UILabel!
    @IBOutlet private weak var translatedWordLanguageLabel: UILabel!
    @IBOutlet private weak var originalContextLabel: UILabel!
    @IBOutlet private weak var addToDictionaryButton: UIButton!

    private var translatedText: TranslatedText?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(text: TranslatedText) {
        translatedWordLabel.text = text.translated
        translatedWordLanguageLabel.text = text.original.dominantLanguage.localized
        originalContextLabel.text = text.original.context

        translatedText = text
    }

    @IBAction private func onAddToDictionaryButtonPressed(_ sender: UIButton) {
        if let entry = translatedText?.original.dictionaryEntry {
            DictionaryManager.shared.add(entry: entry)
        }
    }

}
