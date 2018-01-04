import UIKit

final class TranslationHistoryViewController: UITableViewController, TranslateManagerObserver {

    private var history: [TranslatedText]? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        TranslateManager.shared.subscribe(observer: self)
        history = TranslateManager.shared.storage
    }

    deinit {
        TranslateManager.shared.unsubscribe(observer: self)
    }

    // MARK: - TranslateManagerObserver protocol

    func storageManager<Manager, Entry>(_ storageManager: Manager, onDataChangedFor entry: Entry) where Manager : StorageManager, Entry : Storable {
        DispatchQueue.main.async { [weak self] in
            self?.history = storageManager.storage as? [TranslatedText]
            self?.tableView.reloadData()
        }
    }

    @IBAction private func onDoneButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofClass: TranslationHistoryRecordTableViewCell.self, for: indexPath)
        if let text = history?[indexPath.row] {
            cell.configure(text: text)
        }
        return cell
    }

}
