import UIKit

class ChatHelperViewController: UITableViewController {

    var translationHistory: [[String:String]]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return translationHistory?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatHelperTableViewCell", for: indexPath)
        let translation = translationHistory?[indexPath.row]
        translation?.forEach {
            cell.textLabel?.text = $0.key
            cell.detailTextLabel?.text = $0.value
        }

        return cell
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true) { self.parent?.dismiss(animated: true, completion: nil) }
    }

}

fileprivate extension ChatHelperViewController {

    func prepareBackgroundView() {
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .extraLight)
        let visualEffect = UIVisualEffectView(effect: blurEffect)
        let bluredView = UIVisualEffectView(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)

        let screenBounds = UIScreen.main.bounds
        visualEffect.frame = screenBounds
        bluredView.frame = screenBounds
        view.insertSubview(bluredView, at: 0)
    }

}
