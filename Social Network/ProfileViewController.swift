import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - Internal properties

    var userID: UserID? {
        didSet {
            updateProfile()
        }
    }

    // MARK: - Private properties

    private let client = SocialNetworkClient.default

    private var user: User? {
        didSet {
            guard let user = user, isViewLoaded else { return }

            populateUI(with: user)
        }
    }

    private var subscribers: [User]? {
        didSet {
            if let subscribers = subscribers {
                subscribersNumberLabel.text = "\(subscribers.count)"
            }
            else {
                subscribersNumberLabel.text = nil
            }
        }
    }

    private var subscribtions: [User]? {
        didSet {
            if let subscribtions = subscribtions {
                subscribtionsNumberLabel.text = "\(subscribtions.count)"
            }
            else {
                subscribtionsNumberLabel.text = nil
            }
        }
    }

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
    @IBOutlet private weak var subscribersNumberLabel: UILabel!
    @IBOutlet private weak var subscribersDescriptionLabel: UILabel!
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

        updateProfile()

        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        switch identifier {
        case .showSubscribers:
            prepareUserListViewController(segue.destination, for: .subsribers)

        case .showSubscriptions:
            prepareUserListViewController(segue.destination, for: .subscribtions)

        default:
            return
        }
    }

    // MARK: - Private methods

    @objc private dynamic func refresh(_ sender: UIRefreshControl) {
        updateProfile()
        sender.endRefreshing()
    }

    @objc private dynamic func logout(_ sender: Any) {
        client.logout { [weak self] _ in
//            let viewController = self?.storyboard?.instantiateViewController(withIdentifier: UIStoryboard.Login)
//            let window = (UIApplication.shared.delegate as! AppDelegate).window
//            window?.rootViewController = viewController
//            window?.makeKeyAndVisible()
//
//            viewController?.view.alpha = 0
//            UIView.animate(withDuration: 0.2) { viewController?.view.alpha = 1 }
        }
    }

    private func prepareUserListViewController(_ viewController: UIViewController, for list: UserListTableViewController.List) {
        guard let viewController = viewController as? UserListTableViewController else { return }
        switch list {
        case .none:
            return

        case .subsribers:
            if let subscribers = subscribers {
                viewController.configure(with: subscribers, for: list)
            }

        case .subscribtions:
            if let subscribtions = subscribtions {
                viewController.configure(with: subscribtions, for: list)
            }
        }
    }

    private func updateProfile() {
        UserManager.shared.getUser(with: userID) { [weak self] user in
            self?.user = user

            if let userID = user?.id {
                self?.updateRelations(of: userID)
            }
        }
    }

    private func warn(with serverResponse: ClientConstants.ServerResponse) {
        warningLabel.isHidden = false
        warningLabel.text = "Couldn't Load"
        print(serverResponse)

        indicator.isHidden = true
    }

    private func updateRelations(of userID: UserID) {
        client.getSubscribers(of: userID) { [weak self] request in
            switch request {
            case let .fail(response):
                return

            case let .success(subscribers):
                self?.subscribers = subscribers
            }
        }

        client.getSubscribtions(of: userID) { [weak self] request in
            switch request {
            case let .fail(response):
                return

            case let .success(subscribtions):
                self?.subscribtions = subscribtions
            }
        }
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
        subscribtionsNumberLabel.text = nil
        subscribersNumberLabel.text = nil

        indicator.isHidden = true
    }

    private func makeStackView(for language: Language) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally

        let languageNameLabel = UILabel()
        languageNameLabel.font = subscribersNumberLabel.font
        languageNameLabel.text = language.name.localized
        stackView.addArrangedSubview(languageNameLabel)

        let languageLevelLabel = UILabel()
        languageLevelLabel.font = subscribersDescriptionLabel.font
        languageLevelLabel.textColor = subscribersDescriptionLabel.textColor
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
            followButton.addTarget(self, action: #selector(followUser(_:)), for: .touchUpInside)

            let messageButton = UIButton(type: .system)
            messageButton.setTitle("Message", for: .normal)
            messageButton.titleLabel?.textAlignment = .center
            messageButton.addTarget(self, action: #selector(openChatViewController(_:)), for: .touchUpInside)

            return [followButton, messageButton]
        }
    }

    @objc private dynamic func openChatViewController(_ sender: Any) {
        let storyboard = UIStoryboard(name: UIStoryboard.Conversations.id, bundle: .main)
        if let viewController = storyboard.instantiateViewController(withIdentifier: ChatViewController.id) as? ChatViewController {
            viewController.userID = userID
            show(viewController, sender: self)
        }
    }

    @objc private dynamic func followUser(_ sender: Any) {
        guard let userID = userID else { return }
        client.friend(userID) { [weak self] request in
            switch request {
            case let .fail(response):
                return

            case .success:
                guard let followButton = self?.actionStackView.arrangedSubviews.first as? UIButton else {
                    return
                }

                followButton.setTitle("Unfollow", for: .normal)
            }
        }
    }
    
}

private extension String {

    static var showSubscribers: String {
        return "showSubscribers"
    }

    static var showSubscriptions: String {
        return "showSubscriptions"
    }

}
