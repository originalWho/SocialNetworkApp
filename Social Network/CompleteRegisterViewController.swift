import UIKit

class CompleteRegisterViewController: UIViewController {

    // MARK: - Typealiases

    fileprivate typealias Key = SocialNetworkClient.ParameterKeys

    // MARK: - Outlets

    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var languagesStackView: UIStackView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var motherLanguageTextField: UITextField!

    // MARK: - Private properties

    fileprivate let client = SocialNetworkClient.default

    fileprivate var countryPicker: UIPickerView?
    fileprivate var birthdayPicker: UIDatePicker?
    fileprivate var languagePickers = [UIPickerView]()
    fileprivate var languageTextFields = [UITextField]()
    fileprivate var countryPickerDelegate: UserInfoPicker?
    fileprivate var languagePickerDelegates = [UserInfoPicker]()
    fileprivate var addLanguageButtons = [UIButton]()

    fileprivate var userInfo = [String: Any]()
    fileprivate var selectedLanguages = [UITextField:Language]()


    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.isHidden = true
        indicator.isHidden = true

        configureCountryPicker()
        configureLanguagePicker(for: motherLanguageTextField)
        languageTextFields.append(motherLanguageTextField)
        configureBirthdayPicker()
        makeAnotherLanguageField()
        subscribeToNotifications()
    }

    override func viewDidDisappear(_ animated: Bool) {
        unsubscribeFromNotifications()
        super.viewDidDisappear(animated)
    }

}

// MARK: - Actions

extension CompleteRegisterViewController {

    @IBAction func submit(_ sender: Any) {
        setUI(enabled: false)

        func warn(with warning: WarningMessage) {
            warningLabel.text = warning.rawValue
            setUI(enabled: true)
        }

        guard let _ = userInfo[Key.Country] else {
            warn(with: .notChosenCountry)
            return
        }

        guard let _ = userInfo[Key.Birthday] else {
            warn(with: .notChosenBirthday)
            return
        }

        if userInfo[Key.Gender] == nil {
            userInfo[Key.Gender] = Gender.Male.rawValue
        }

        guard !selectedLanguages.isEmpty else {
            warn(with: .notChosenMotherLanguage)
            return
        }

        var languages = [String:String]()
        selectedLanguages.filter { $0.value.name != .None && $0.value.level != .None }
            .forEach { languages[$0.value.name.stringValue.uppercased()] = $0.value.level.stringValue.uppercased() }
        userInfo[Key.Languages] = languages

        client.completeRegister(parameters: userInfo) { [weak self] response in
            guard let response = response, response == .success else {
                warn(with: .unknownError)
                return
            }
            
            SocialNetworkClient.Settings.registerComplete = true
            self?.dismiss(animated: true) {
                let viewController = self?.storyboard?.instantiateViewController(withIdentifier: UIStoryboard.Main)
                let window = (UIApplication.shared.delegate as! AppDelegate).window
                window?.rootViewController = viewController
                window?.makeKeyAndVisible()

                viewController?.view.alpha = 0
                UIView.animate(withDuration: 0.2) { viewController?.view.alpha = 1 }
            }
        }
    }

    private func setUI(enabled: Bool) {
        submitButton.isEnabled = enabled
        submitButton.isHidden = !enabled
        indicator.isHidden = enabled
        warningLabel.isHidden = !enabled
        countryTextField.isEnabled = enabled
        birthdayTextField.isEnabled = enabled
        genderSegmentedControl.isEnabled = enabled

        languageTextFields.forEach { $0.isEnabled = enabled }
    }

}

// MARK: - Notifications handlers

extension CompleteRegisterViewController {

    func didSelectBirthday(_ sender: Any) {
        guard let birthdayPicker = birthdayPicker else {
            return
        }

        let dateFormatter = DateFormatter()
        let date = birthdayPicker.date
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let birthday = dateFormatter.string(from: date)

        birthdayTextField.text = birthday
        userInfo[Key.Birthday] = birthday
    }

    func didSelectCountry(_ notification: Notification) {
        guard let country = notification.object as? Country else {
            return
        }

        countryTextField.text = country.stringValue
        userInfo[Key.Country] = country.rawValue
    }

    @IBAction func didSelectGender(_ sender: Any) {
        let index = genderSegmentedControl.selectedSegmentIndex
        guard let gender = Gender(rawValue: index + 1) else {
            return
        }

        userInfo[Key.Gender] = gender.rawValue
    }

    func didSelectLanguage(_ notification: Notification) {
        guard let language = notification.object as? Language else {
            return
        }

        languageTextFields.filter { $0.isFirstResponder }.forEach {
            $0.text = language.name.stringValue
            selectedLanguages[$0] = language
        }
    }

    func didAddAnotherLanguage(_ sender: Any) {
        makeAnotherLanguageField()
    }

    func keyboardWillShow(_ notification:Notification) {
        let keyboardHeight = getKeyboardHeight(notification)
        let offset = getOffset(notification)
        if keyboardHeight >= offset {
            self.view.frame.origin.y -= keyboardHeight
        } else {
            self.view.frame.origin.y += keyboardHeight - offset
        }
    }

    func keyboardWillHide(_ notification:Notification) {
        if self.view.frame.origin.y < 0 {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }

}

// MARK: - Private methods

fileprivate extension CompleteRegisterViewController {

    func configureCountryPicker() {
        countryPicker = UIPickerView()
        countryPickerDelegate = UserInfoPicker(type: .country)
        countryPicker?.delegate = countryPickerDelegate
        countryPicker?.dataSource = countryPickerDelegate
        countryTextField.inputView = countryPicker
    }

    func configureLanguagePicker(for textField: UITextField) {
        let picker = UIPickerView()
        let delegate = UserInfoPicker(type: .language)
        picker.delegate = delegate
        picker.dataSource = delegate

        languagePickers.append(picker)
        languagePickerDelegates.append(delegate)

        textField.inputView = picker
    }

    func configureBirthdayPicker() {
        birthdayPicker = UIDatePicker()
        birthdayPicker?.datePickerMode = .date
        birthdayPicker?.maximumDate = Date()
        birthdayTextField.inputView = birthdayPicker
    }

    func makeAnotherLanguageField() {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally

        let textField = UITextField()
        textField.placeholder = "Another Language"
        textField.borderStyle = .roundedRect
        textField.font = countryTextField.font
        configureLanguagePicker(for: textField)

        languageTextFields.append(textField)
        stackView.addArrangedSubview(textField)

        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.addTarget(self, action: #selector(didAddAnotherLanguage(_:)), for: .touchUpInside)

        addLanguageButtons.last?.isEnabled = false
        if languageTextFields.count > 3 {
            button.isEnabled = false
        } else {
            addLanguageButtons.append(button)
        }

        stackView.addArrangedSubview(button)
        languagesStackView.addArrangedSubview(stackView)
    }

    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectCountry(_:)),
                                               name: .UICountryPicked, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectLanguage(_:)),
                                               name: .UILanguagePicked, object: nil)
        /*
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: .UIKeyboardWillHide, object: nil)
        */
        birthdayPicker?.addTarget(self, action: #selector(didSelectBirthday(_:)), for: .valueChanged)
    }

    func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }

    func getOffset(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let offset = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return offset.cgRectValue.height
    }

}
