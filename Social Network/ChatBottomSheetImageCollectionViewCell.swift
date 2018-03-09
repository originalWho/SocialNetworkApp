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

    private enum DetectIndicatorState {
        case hidden
        case notDetected
        case detected
    }

    private(set) var state: State = .inactive {
        didSet {
            update(for: state)
        }
    }

    private var detectIndicatorState: DetectIndicatorState = .hidden {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                switch self.detectIndicatorState {
                case .hidden:
                    self.detectIndicator.alpha = 0.0

                case .notDetected:
                    self.detectIndicator.alpha = 0.8
                    self.detectIndicator.backgroundColor = .lightGray

                case .detected:
                    self.detectIndicator.alpha = 0.8
                    self.detectIndicator.backgroundColor = .green
                }
            }
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
    @IBOutlet private weak var addToDictionaryButton: UIButton!
    @IBOutlet private weak var detectIndicator: UIView!

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
    private var detectedObjectTranslatedLabel: String?
    private var detectedObjectImage: UIImage?
    private lazy var ciContext = CIContext()
    private var observations: [String:Float] = [:]

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

    func configure() {
        state = .capturing
    }

    @objc private dynamic func onTapGestureRecognized(_ sender: Any) {
        guard captureSession.isRunning, state == .capturing,
            detectIndicatorState == .detected else {
                return
        }

        guard let detectedObjectLabel = observations.sorted(by: { $0.value > $1.value }).first?.key else { return }

        detectedObjectTranslatedLabel = detectedObjectLabel

        state = .checking
        translateService?.translate(detectedObjectLabel) { translatedLabel in
            DispatchQueue.main.async { [weak self] in
                self?.label.text = translatedLabel
                self?.state = .verifying
            }
        }
    }

    @IBAction private func onCorrectButtonPressed(_ sender: UIButton) {
        if state == .verifying {
            state = .translating
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self]  in
                self?.label.text = self?.detectedObjectTranslatedLabel
                self?.state = .translated
            }
        }
        else if state == .translated {
            NotificationCenter.default.post(name: NSNotification.Name("FooBar"), object: label.text)
            state = .inactive
        }
    }

    @IBAction private func onRetryButtonPressed(_ sender: UIButton) {
        state = .capturing
    }

    @IBAction private func onAddToDictionaryButtonPressed(_ sender: UIButton) {
        guard state == .translated, let detectedObjectTranslatedLabel = detectedObjectTranslatedLabel else { return }

        let dictionaryEntry = DictionaryEntry(value: detectedObjectTranslatedLabel,
                                              context: nil,
                                              photo: detectedObjectImage,
                                              language: .english,
                                              lexicalClass: .noun)
        DictionaryManager.shared.add(entry: dictionaryEntry)

        sender.isEnabled = false
    }

    private func configureVision() {
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else { return }

        let classificationRequest = VNCoreMLRequest(model: model) { request, error in
            guard let observation = request.results?
                .flatMap({ $0 as? VNClassificationObservation })
                .filter({ $0.confidence > 0.3 })
                .sorted(by: { $0.confidence > $1.confidence })
                .first else { return }

            if let confidence = self.observations[observation.identifier] {
                self.observations[observation.identifier] = observation.confidence + confidence
            }
            else {
                self.observations[observation.identifier] = observation.confidence
            }

            self.detectIndicatorState = .detected
        }

        classificationRequest.imageCropAndScaleOption = .centerCrop

//        let detectRectanglesRequest = VNDetectRectanglesRequest { request, error in
//            guard let observations = request.results as? [VNRectangleObservation] else { return }
//
//        }
//
//        visionRequests = [classificationRequest, detectRectanglesRequest]
        visionRequests = [classificationRequest]
    }

    private func update(for state: State) {
        let infoVisible: Bool
        let buttonsVisible: Bool
        let activityIndicatorVisible: Bool

        switch state {
        case .inactive:
            infoVisible = false
            buttonsVisible = false
            activityIndicatorVisible = true
            detectedObjectLabel = nil
            detectedObjectImage = nil
            detectedObjectTranslatedLabel = nil
            observations = [:]
            captureSession.stopRunning()

        case .capturing:
            infoVisible = false
            buttonsVisible = false
            activityIndicatorVisible = false
            detectedObjectLabel = nil
            detectedObjectImage = nil
            detectedObjectTranslatedLabel = nil
            observations = [:]
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
            observations = [:]

        case .translating:
            infoVisible = false
            buttonsVisible = false
            activityIndicatorVisible = true
            observations = [:]

        case .translated:
            infoVisible = true
            buttonsVisible = true
            activityIndicatorVisible = false
            observations = [:]
        }

        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let `self` = self else { return }

            self.dimmerView.alpha = (infoVisible || buttonsVisible || activityIndicatorVisible) ? 0.6 : 0.0

            self.infoContainerView.alpha = (infoVisible || activityIndicatorVisible) ? 1.0 : 0.0
            self.label.alpha = (infoVisible && !activityIndicatorVisible) ? 1.0 : 0.0

            self.buttonsContainerView.alpha = buttonsVisible ? 1.0 : 0.0
            self.buttonsContainerView.isUserInteractionEnabled = buttonsVisible

            self.addToDictionaryButton.alpha = (state == .translated) ? 1.0 : 0.0
            self.addToDictionaryButton.isUserInteractionEnabled = (state == .translated)
            if let detectedObjectTranslatedLabel = self.detectedObjectTranslatedLabel {
                self.addToDictionaryButton.isEnabled = !DictionaryManager.shared.storage.contains(where: { $0.value == detectedObjectTranslatedLabel})
            }
            else {
                self.addToDictionaryButton.isEnabled = false
            }

            self.retryButton.alpha = (state == .verifying) ? 1.0 : 0.0
            self.retryButton.isUserInteractionEnabled = (state == .verifying)

            self.rightButton.setTitle((state == .verifying) ? "Right" : "Paste", for: .normal)

            if activityIndicatorVisible {
                self.activityIndicator.startAnimating()
            }
            else {
                self.activityIndicator.stopAnimating()
            }

            self.detectIndicatorState = (state == .capturing) ? .notDetected : .hidden
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

        let ciImage = CIImage(cvImageBuffer: pixelBuffer)
        if let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent) {
            detectedObjectImage = UIImage(cgImage: cgImage)
        }
    }

}
