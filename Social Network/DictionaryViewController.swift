import UIKit

final class DictionaryViewController: UITableViewController, DictionaryManagerObserver {

    private var entries: [DictionaryEntry]?

    override func viewDidLoad() {
        super.viewDidLoad()

        DictionaryManager.shared.subscribe(observer: self)
        entries = DictionaryManager.shared.storage
    }

    deinit {
        DictionaryManager.shared.unsubscribe(observer: self)
    }

    func prepareForModalPresentation() {
        let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                         target: self, action: #selector(onDoneButtonPressed(_:)))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = nil
    }

    @objc private dynamic func onDoneButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func onHistoryButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: .presentTranslationHistoryViewController, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        switch identifier {
        case .showDictionaryEntryViewController:
            prepareDictionaryEntryViewController(segue.destination, forEntryAt: tableView.indexPathForSelectedRow)

        default:
            return
        }
    }

    private func prepareDictionaryEntryViewController(_ viewController: UIViewController, forEntryAt indexPath: IndexPath?) {
        guard let viewController = viewController as? DictionaryEntryViewController, let indexPath = indexPath,
            let entry = entries?[indexPath.row] else { return }

        viewController.entry = entry

        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - DictionaryManagerObserver

    func storageManager<Manager, Entry>(_ storageManager: Manager, onDataChangedFor entry: Entry) where Manager : StorageManager, Entry : Storable {
        DispatchQueue.main.async { [weak self] in
            self?.entries = storageManager.storage as? [DictionaryEntry]
            self?.tableView.reloadData()
        }
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofClass: DictionaryEntryTableViewCell.self, for: indexPath)
        if let entry = entries?[indexPath.row] {
            cell.configure(entry: entry)
        }
        return cell
    }

}

private extension String {

    static var showDictionaryEntryViewController: String {
        return "showDictionaryEntryViewController"
    }

    static var presentTranslationHistoryViewController: String {
        return "presentTranslationHistoryViewController"
    }

}
