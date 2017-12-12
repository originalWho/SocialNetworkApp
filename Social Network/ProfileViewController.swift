import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - Public properties

    var user: User?

    // MARK: - Private properties

    private let client = SocialNetworkClient.default

    // MARK: - Outlets

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var sexLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var actionStackView: UIStackView!
    @IBOutlet private weak var languageStackView: UIStackView!
    @IBOutlet private weak var relationshipsStackView: UIStackView!
    @IBOutlet private weak var friendsNumberLabel: UILabel!
    @IBOutlet private weak var friendsLabel: UILabel!
    @IBOutlet private weak var subscribersNumberLabel: UILabel!
    @IBOutlet private weak var subscribtionsNumberLabel: UILabel!
    @IBOutlet private weak var bioLabel: UILabel!
    @IBOutlet private weak var bioTextView: UITextView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var warningLabel: UILabel!

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        if (user == nil || user?.id == SocialNetworkClient.Settings.userId) {
            let rightBarButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout(_:)))
            navigationItem.setRightBarButton(rightBarButton, animated: true)
        }

        if (user == nil) {
            loadProfile()
        } else {
            populateUI(with: user!)
        }

        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }

    // MARK: - IBActions

    @IBAction private func showFriends(_ sender: Any) {
        show(.friends)
    }

    @IBAction private func showSubscribers(_ sender: Any) {
        show(.subsribers)
    }

    @IBAction private func showSubscribtions(_ sender: Any) {
        show(.subscribtions)
    }

    // MARK: - Private methods

    private dynamic func refresh(_ sender: UIRefreshControl) {
        DispatchQueue.main.async {
            self.loadProfile()
            sender.endRefreshing()
        }
    }

    private dynamic func logout(_ sender: Any) {
        client.logout { [weak self] _ in
            let viewController = self?.storyboard?.instantiateViewController(withIdentifier: UIStoryboard.Login)
            let window = (UIApplication.shared.delegate as! AppDelegate).window
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()

            viewController?.view.alpha = 0
            UIView.animate(withDuration: 0.2) { viewController?.view.alpha = 1 }
        }
    }

    private enum Relationships {
        case friends
        case subsribers
        case subscribtions
    }

    private func show(_ relationship: Relationships) {
        let usersViewController = storyboard?.instantiateViewController(withIdentifier: UIStoryboard.UserList)
        navigationController?.pushViewController(usersViewController!, animated: true)
    }

    private func loadProfile() {
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
        }
    }

    private func warn(with serverResponse: ClientConstants.ServerResponse) {
        warningLabel.isHidden = false
        warningLabel.text = "Couldn't Load"
        print(serverResponse)

        indicator.isHidden = true
    }

    private func populateUI(with user: User) {
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
            for subview in languageStackView.arrangedSubviews {
                languageStackView.removeArrangedSubview(subview)
                subview.removeFromSuperview()
            }
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
        for subview in actionStackView.arrangedSubviews {
            actionStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        let actions = (SocialNetworkClient.Settings.userId == user.id)
            ? makeActions(for: .mine)
            : makeActions(for: .theirs)
        actions.forEach { actionStackView.addArrangedSubview($0) }

        relationshipsStackView.isHidden = false
        friendsNumberLabel.text = "20"
        subscribersNumberLabel.text = "144"
        subscribtionsNumberLabel.text = "1021"

        indicator.isHidden = true
    }

    private func makeStackView(for language: Language) -> UIStackView {
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

    private enum Profile {
        case mine
        case theirs
    }

    private func makeActions(for profile: Profile) -> [UIButton] {
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
