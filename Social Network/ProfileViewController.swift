import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Public properties

    var user: User?

    // MARK: - Private properties

    fileprivate let client = SocialNetworkClient.default

    // MARK: - Outlets

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var actionStackView: UIStackView!
    @IBOutlet weak var languageStackView: UIStackView!
    @IBOutlet weak var relationshipsStackView: UIStackView!
    @IBOutlet weak var friendsNumberLabel: UILabel!
    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet weak var subscribersNumberLabel: UILabel!
    @IBOutlet weak var subscribtionsNumberLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var warningLabel: UILabel!

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        if (user == nil) {
            loadProfile()
        } else {
            populateUI(with: user!)
        }
    }

}

fileprivate extension ProfileViewController {

    func loadProfile() {
        client.getProfile(user?.id) { [weak self] request in
            guard let this = self else {
                return
            }

            switch request {
            case .fail(let response):
                this.warn(with: response)

            case .success(let user):
                this.populateUI(with: user)
            }

            this.indicator.isHidden = true
        }
    }

    func warn(with serverResponse: SocialNetworkClient.ServerResponse) {
        warningLabel.isHidden = false
        warningLabel.text = "Couldn't Load"
        print(serverResponse)
    }

    func populateUI(with user: User) {
        if true {
            profileImageView.isHidden = false
        }

        if let name = user.name {
            nameLabel.isHidden = false
            nameLabel.text = name
        }

        if let age = user.age {
            ageLabel.isHidden = false
            ageLabel.text = "\(age)"
        }

        if let gender = user.gender {
            sexLabel.isHidden = false
            sexLabel.text = gender.localized
        }

        if let country = user.country {
            countryLabel.isHidden = false
            countryLabel.text = country.localized
        }

        if let languages = user.languages {
            languageStackView.isHidden = false
            for language in languages {
                let stackView = makeStackView(for: language)
                languageStackView.addArrangedSubview(stackView)
            }
        }

        if let bio = user.about {
            bioLabel.isHidden = false
            bioTextView.isHidden = false
            bioTextView.text = bio
        }

        actionStackView.isHidden = false
        let actions = (user == nil)
            ? makeActions(for: .mine)
            : makeActions(for: .theirs)
        actions.forEach { actionStackView.addArrangedSubview($0) }

        relationshipsStackView.isHidden = false
        friendsNumberLabel.text = "20"
        subscribersNumberLabel.text = "144"
        subscribtionsNumberLabel.text = "1021"
    }

    func makeStackView(for language: Language) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally

        let languageNameLabel = UILabel()
        languageNameLabel.font = friendsNumberLabel.font
        languageNameLabel.text = language.name.localized
        stackView.addArrangedSubview(languageNameLabel)

        let languageLevelLabel = UILabel()
        languageLevelLabel.font = friendsLabel.font
        languageLevelLabel.textColor = friendsLabel.textColor
        languageLevelLabel.text = language.level.localized
        stackView.addArrangedSubview(languageLevelLabel)

        return stackView
    }

    enum Profile {
        case mine
        case theirs
    }

    func makeActions(for profile: Profile) -> [UIButton] {
        switch profile {
        case .mine:
            let editButton = UIButton(type: .system)
            editButton.setTitle("Edit", for: .normal)
            editButton.titleLabel?.textAlignment = .center

            return [editButton]

        case .theirs:
            let followButton = UIButton(type: .system)
            followButton.setTitle("Follow", for: .normal)
            followButton.titleLabel?.textAlignment = .center

            let messageButton = UIButton(type: .system)
            messageButton.setTitle("Message", for: .normal)
            messageButton.titleLabel?.textAlignment = .center

            return [followButton, messageButton]
        }
    }
}
