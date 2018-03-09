import UIKit

protocol ChatBottomSheetViewControllerDelegate: class {

    func onBottomSheetDragDown(_ bottomSheetViewController: ChatBottomSheetViewController)

}

final class ChatBottomSheetViewController: UICollectionViewController {

    weak var delegate: ChatBottomSheetViewControllerDelegate?

    private(set) var text: LSExtractedWord?

    private var infoProviders: [ChatBottomSheetInfoProvider]?
    private var fetchedInfo: [String:String] = [:]
    private(set) var strategy: ChatBottomSheetViewControllerStrategy = .none {
        didSet {
            infoProviders = strategy.infoProviders
            collectionView?.reloadData()
        }
    }

    func configure(for strategy: ChatBottomSheetViewControllerStrategy, with text: LSExtractedWord? = nil) {
        self.text = text
        self.fetchedInfo = [:]
        self.strategy = strategy

        guard let text = text, let infoProviders = infoProviders else { return }

        for infoProvider in infoProviders {
            infoProvider.fetchInfo(for: text) { [weak self] original, info in
                self?.fetchedInfo[infoProvider.name] = info
                self?.collectionView?.reloadData()
            }
        }
    }

    private func cleanUp() {
        text = nil
        fetchedInfo = [:]
//        strategy = .none
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoProviders?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch strategy {
        case .none, .translation, .lookUp:
            let cell = collectionView.dequeueReusableCell(ofClass: ChatBottomSheetCollectionViewCell.self, for: indexPath)
            if let text = text, let infoProvider = infoProviders?[indexPath.row] {
                cell.configure(title: text.value, description: infoProvider.description,
                               body: fetchedInfo[infoProvider.name], providerName: infoProvider.name)
            }
            return cell

        case .imageTranslation:
            let cell = collectionView.dequeueReusableCell(ofClass: ChatBottomSheetImageCollectionViewCell.self, for: indexPath)
            cell.configure()
            return cell
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -(scrollView.contentSize.height * 0.25) {
            delegate?.onBottomSheetDragDown(self)
            cleanUp()
        }
    }

}
