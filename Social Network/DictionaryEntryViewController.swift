import UIKit

final class DictionaryEntryViewController: UITableViewController {

    private enum Row {
        case word
        case photo
        case context
        case definitions
        case synonyms
        case antonyms
        case usageExamples
    }

    var entry: DictionaryEntry? {
        didSet {
            guard let entry = entry else {
                self.rows = []
                return
            }

            var rows: [Row] = [.word]
            if entry.photo != nil {
                rows.append(.photo)
            }
            if entry.context != nil {
                rows.append(.context)
            }
            if entry.definitions != nil {
                rows.append(.definitions)
            }
            if entry.synonyms != nil {
                rows.append(.synonyms)
            }
            if entry.antonyms != nil {
                rows.append(.antonyms)
            }
            if entry.usageExamples != nil {
                rows.append(.usageExamples)
            }

            self.rows = rows
        }
    }

    private var rows: [Row]? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = rows?[indexPath.row], let entry = entry else { return UITableViewCell() }

        switch row {
        case .word:
            let cell = tableView.dequeueReusableCell(ofClass: DictionaryWordTableViewCell.self, for: indexPath)
            cell.configure(entry: entry)
            return cell

        case .photo:
            let cell = tableView.dequeueReusableCell(ofClass: DictionaryPhotoTableViewCell.self, for: indexPath)
            cell.configure(image: entry.photo)
            return cell

        case .context:
            let cell = tableView.dequeueReusableCell(ofClass: DictionaryContextTableViewCell.self, for: indexPath)
            cell.configure(title: "Context", text: entry.context)
            return cell

        default:
            let cell = tableView.dequeueReusableCell(ofClass: DictionaryContextTableViewCell.self, for: indexPath)
            return cell
        }
    }

}
