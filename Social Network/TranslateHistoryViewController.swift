import UIKit

class TranslateHistoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }

}

fileprivate extension TranslateHistoryViewController {

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
