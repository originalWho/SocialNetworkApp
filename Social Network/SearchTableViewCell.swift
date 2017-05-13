import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var languagesStackView: UIStackView!

    func configure(with user: User) {
        nameLabel.text = user.name
        countryLabel.text = user.country?.localized
        onlineLabel.isHidden = !user.online!

        guard let languages = user.languages else {
            return
        }

        for language in languages {
            let stackView = makeStackView(for: language)
            languagesStackView.addArrangedSubview(stackView)
        }
    }

    fileprivate func makeStackView(for language: Language) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally

        let nameLabel = UILabel()
        nameLabel.text = language.name.localized
        stackView.addArrangedSubview(nameLabel)

        let levelLabel = UILabel()
        levelLabel.text = language.level.localized
        levelLabel.textColor = .darkGray
        stackView.addArrangedSubview(levelLabel)

        return stackView
    }

}
