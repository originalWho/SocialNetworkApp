import UIKit

class ChatTextView: UITextView {

    private let customActions: [Selector] = [
        #selector(translateSelected(_:)),
        #selector(commentSelected(_:))
    ]

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return customActions.contains(action)
    }

    func translateSelected(_ sender: Any) {
        guard let selectedTextRange = selectedTextRange,
            let selectedText = text(in: selectedTextRange) else {
                return
        }

        NotificationCenter.default.post(name: .UITranslateSelected, object: selectedText)
    }

    func commentSelected(_ sender: Any) {
        guard let selectedTextRange = selectedTextRange,
            let selectedText = text(in: selectedTextRange) else {
                return
        }

        NotificationCenter.default.post(name: .UICommentSelected, object: selectedText)
    }

}
