import UIKit

final class TranslateBottomSheetViewController: UIViewController {

    // MARK: - Private properties

    fileprivate let screenBounds = UIScreen.main.bounds
    fileprivate let fullView: CGFloat = 400

    // MARK: - Outlets

    @IBOutlet weak var selectedTextLabel: UILabel!
    @IBOutlet weak var translatedTextLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

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


    // MARK: - Public methods

    func setTranslated(text: String) {
        indicator.isHidden = true
        translatedTextLabel.isHidden = false
        translatedTextLabel.text = text
    }

}

// MARK: - Actions 

extension TranslateBottomSheetViewController {

    @IBAction func drag(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let y = view.frame.minY

        if y + translation.y > fullView {
            view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: view)
        }

        if recognizer.state == .ended {
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.view.removeFromSuperview()
                self?.removeFromParentViewController()
            })
        }
    }

}

// MARK: - Private methods

fileprivate extension TranslateBottomSheetViewController {

    func prepareBackgroundView() {
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
