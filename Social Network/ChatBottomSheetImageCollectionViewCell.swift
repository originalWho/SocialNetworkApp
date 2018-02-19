import UIKit
import AVFoundation

struct MockProvider: ChatBottomSheetInfoProvider {

    var description: String {
        return "Hey"
    }

    var name: String {
        return "Mock"
    }

    func fetchInfo(for text: LSExtractedWord, completion: @escaping (LSExtractedWord, String?) -> Void) {

    }

}

final class ChatBottomSheetImageCollectionViewCell: UICollectionViewCell {

    enum State {
        case none
        case capturing
        case checking
        case verifying
        case translating
        case translated
    }

    private(set) var state: State = .none {
        didSet {
            updateLayout(for: state)
        }
    }

    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var dimmerView: UIView!
    @IBOutlet private weak var infoContainerView: UIView!
    @IBOutlet private weak var buttonsContainerView: UIView!
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var rightButton: UIButton!
    @IBOutlet private weak var retryButton: UIButton!
    @IBOutlet private weak var infoProviderLabel: UILabel!

    private lazy var capturePreviewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    private lazy var captureSession: AVCaptureSession = {
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium

        guard let camera = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: camera) else {
                return captureSession
        }

        captureSession.addInput(input)
        return captureSession
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        capturePreviewLayer.videoGravity = .resizeAspectFill
        capturePreviewLayer.cornerRadius = 20
        imageContainerView.layer.addSublayer(capturePreviewLayer)

        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "MyQueue"))
        captureSession.addOutput(videoOutput)
        captureSession.startRunning()

        state = .capturing
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        capturePreviewLayer.frame = imageContainerView.bounds
    }

    private func updateLayout(for state: State) {
        let infoVisible: Bool
        let buttonsVisible: Bool
        let activityIndicatorVisible: Bool

        switch state {
        case .none:
            infoVisible = false
            buttonsVisible = false
            activityIndicatorVisible = true
            captureSession.stopRunning()

        case .capturing:
            infoVisible = false
            buttonsVisible = false
            activityIndicatorVisible = false
            captureSession.startRunning()

        case .checking:
            infoVisible = false
            buttonsVisible = false
            activityIndicatorVisible = true
            captureSession.stopRunning()

        case .verifying:
            infoVisible = true
            buttonsVisible = true
            activityIndicatorVisible = false

        case .translating:
            infoVisible = false
            buttonsVisible = false
            activityIndicatorVisible = true

        case .translated:
            infoVisible = true
            buttonsVisible = true
            activityIndicatorVisible = false
        }

        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let `self` = self else { return }

            self.dimmerView.alpha = (infoVisible || buttonsVisible || activityIndicatorVisible) ? 0.6 : 0.0
            self.infoContainerView.alpha = (infoVisible || activityIndicatorVisible) ? 1.0 : 0.0
            self.label.alpha = (infoVisible && !activityIndicatorVisible) ? 1.0 : 0.0

            self.buttonsContainerView.alpha = buttonsVisible ? 1.0 : 0.0
            self.buttonsContainerView.isUserInteractionEnabled = buttonsVisible

            if activityIndicatorVisible {
                self.activityIndicator.startAnimating()
            }
            else {
                self.activityIndicator.stopAnimating()
            }
        }
    }

}

extension ChatBottomSheetImageCollectionViewCell: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

    }

}
