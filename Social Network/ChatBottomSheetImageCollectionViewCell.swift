import UIKit
import Vision
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
        case inactive
        case capturing
        case checking
        case verifying
        case translating
        case translated
    }

    private(set) var state: State = .inactive {
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
    private lazy var translateService = YandexTranslate()

    private var visionRequests: [VNRequest] = []
    private var detectedObjectLabel: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        capturePreviewLayer.videoGravity = .resizeAspectFill
        capturePreviewLayer.cornerRadius = 20
        imageContainerView.layer.addSublayer(capturePreviewLayer)

        dimmerView.layer.cornerRadius = 20

        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "MyQueue"))
        captureSession.addOutput(videoOutput)
        captureSession.startRunning()

        configureVision()

        state = .capturing

        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(onTapGestureRecognized(_:)))
        imageContainerView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        capturePreviewLayer.frame = imageContainerView.bounds
    }

    @objc private dynamic func onTapGestureRecognized(_ sender: Any) {
        guard captureSession.isRunning, state == .capturing, let detectedObjectLabel = detectedObjectLabel else {
            return
        }

        state = .checking
        translateService?.translate(detectedObjectLabel) { translatedLabel in
            DispatchQueue.main.async { [weak self] in
                self?.label.text = translatedLabel
                self?.state = .verifying
            }
        }
    }

    @IBAction func onCorrectButtonPressed(_ sender: UIButton) {
        if state == .verifying {
            state = .translating
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self]  in
                self?.label.text = self?.detectedObjectLabel
                self?.state = .translated
            }
        }
        else if state == .translated {
            NotificationCenter.default.post(name: NSNotification.Name("FooBar"), object: label.text)
        }
    }

    @IBAction func onRetryButtonPressed(_ sender: UIButton) {
        state = .capturing
    }

    private func configureVision() {
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else { return }

        let classificationRequest = VNCoreMLRequest(model: model) { request, error in
            guard let observations = request.results else { return }

            let classification = observations
                .flatMap({ $0 as? VNClassificationObservation })
                .filter({ $0.confidence > 0.3 })
                .sorted(by: { $0.confidence > $1.confidence })
                .first?.identifier

            self.detectedObjectLabel = classification
        }

        classificationRequest.imageCropAndScaleOption = .centerCrop

        let detectRectanglesRequest = VNDetectRectanglesRequest { request, error in
            guard let observations = request.results as? [VNRectangleObservation] else { return }

        }

        visionRequests = [classificationRequest, detectRectanglesRequest]
    }

    private func updateLayout(for state: State) {
        let infoVisible: Bool
        let buttonsVisible: Bool
        let activityIndicatorVisible: Bool

        switch state {
        case .inactive:
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

            self.retryButton.alpha = (state == .verifying) ? 1.0 : 0.0
            self.retryButton.isUserInteractionEnabled = (state == .verifying)

            self.rightButton.setTitle((state == .verifying) ? "Right" : "Paste", for: .normal)

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
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

        var requestOptions: [VNImageOption: Any] = [:]

        if let cameraIntrinsicData = CMGetAttachment(sampleBuffer, kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, nil) {
            requestOptions = [.cameraIntrinsics:cameraIntrinsicData]
        }

        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                                        orientation: CGImagePropertyOrientation(rawValue: 1)!, options: requestOptions)
        try? imageRequestHandler.perform(visionRequests)
    }

}
