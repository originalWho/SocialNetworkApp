import UIKit

extension UIView {

    static var id: String {
        return String(describing: self)
    }

}

extension UIViewController {

    static var id: String {
        return String(describing: self)
    }

}

extension UIStoryboard {

    func instantiateViewController<T: UIViewController>(ofClass type: T.Type) -> T {
        guard let viewController = instantiateViewController(withIdentifier: type.id) as? T else {
            assertionFailure("Couldn't instantiate UIViewController of type:<\(type)> with id:<\(type.id)>")
            return T()
        }
        
        return viewController
    }

}
