import UIKit

extension UIView {

    static var id: String {
        return String(describing: self)
    }

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let layerShadowColor = layer.shadowColor {
                return UIColor(cgColor: layerShadowColor)
            }
            else {
                return nil
            }
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

}

extension UIViewController {

    static var id: String {
        return String(describing: self)
    }

}

// MARK: - UIStoryboard

extension UIStoryboard {

    func instantiateViewController<T: UIViewController>(ofClass type: T.Type) -> T {
        guard let viewController = instantiateViewController(withIdentifier: type.id) as? T else {
            assertionFailure("Couldn't instantiate UIViewController of type:<\(type)> with id:<\(type.id)>")
            return T()
        }

        return viewController
    }

}

// MARK: - UITableView

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

// MARK: - UICollectionView

extension UICollectionView {

    func dequeueReusableCell<T: UICollectionViewCell>(ofClass type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.id, for: indexPath) as? T else {
            assertionFailure("Couldn't dequeue reusable cell with identifier:<\(type.id)> for indexPath:<\(indexPath)>")
            return T()
        }

        return cell
    }

}
