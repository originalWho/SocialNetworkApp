import UIKit

extension UITableView {

    func registerCell<T: UITableViewCell>(ofClass type: T.Type) {
        let nib = UINib(nibName: type.id, bundle: .main)
        register(nib, forCellReuseIdentifier: type.id)
    }

    func dequeueReusableCell<T: UITableViewCell>(ofClass type: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.id) as? T else {
            assertionFailure("Couldn't dequeue reusable cell with identifier:<\(type.id)>")
            return T()
        }

        return cell
    }

    func dequeueReusableCell<T: UITableViewCell>(ofClass type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.id, for: indexPath) as? T else {
            assertionFailure("Couldn't dequeue reusable cell with identifier:<\(type.id)> for indexPath:<\(indexPath)>")
            return T()
        }

        return cell
    }

}
