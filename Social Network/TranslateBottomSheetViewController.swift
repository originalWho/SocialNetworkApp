import UIKit

final class TranslateBottomSheetViewController: UIViewController {

    // MARK: - Private properties

    private let screenBounds = UIScreen.main.bounds
    private let fullView: CGFloat = 400

    // MARK: - IBOutlets

    @IBOutlet weak var selectedTextLabel: UILabel!
    @IBOutlet weak var translatedTextLabel: UILabel!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var translateServiceLabel: UILabel!

    // MARK: - Overrides

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let this = self else {
                return
            }

            let frame = this.view.frame
            let yComponent = this.screenBounds.height - 150
            this.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height)
        }
    }

    // MARK: - Internal methods

    func setTranslated(text: String, with service: TranslateService) {
        indicator.isHidden = true
        translatedTextLabel.isHidden = false
        translatedTextLabel.text = text
        translateServiceLabel.text = service.identifier
    }

    // MARK: - IBActions

    @IBAction private func drag(_ recognizer: UIPanGestureRecognizer) {
        let velocity = recognizer.velocity(in: view)
        let translation = recognizer.translation(in: view)
        let y = view.frame.minY

        if y + translation.y > fullView {
            view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(.zero, in: view)
        }

        if recognizer.state == .ended {
            let percent = translation.y / view.frame.height
            let animations: () -> Void = { [weak self] in
                guard let `self` = self else { return }

                if velocity.y > 1000.0 || percent > 0.2 {
                    self.view.removeFromSuperview()
                    self.removeFromParentViewController()
                }
            }

            UIView.animate(withDuration: 0.2, animations: animations)
        }
    }

    // MARK: - Private methods

    private func prepareBackgroundView() {
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .extraLight)
        let visualEffect = UIVisualEffectView(effect: blurEffect)
        let bluredView = UIVisualEffectView(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)

        visualEffect.frame = screenBounds
        bluredView.frame = screenBounds
        view.insertSubview(bluredView, at: 0)
    }

}
