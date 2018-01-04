import UIKit

final class CompleteRegisterViewController: UIViewController {

    // MARK: - Typealiases

    fileprivate typealias Key = ClientConstants.ParameterKeys

    // MARK: - Outlets

    @IBOutlet private weak var warningLabel: UILabel!
    @IBOutlet fileprivate weak var countryTextField: UITextField!
    @IBOutlet private weak var birthdayTextField: UITextField!
    @IBOutlet private weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var languagesStackView: UIStackView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var motherLanguageTextField: UITextField!

    // MARK: - Private properties

    private let client = SocialNetworkClient.default

    private var countryPicker: UIPickerView?
    private var birthdayPicker: UIDatePicker?
    private var languagePickers = [UIPickerView]()
    fileprivate var languageTextFields = [UITextField]()
    private var countryPickerDelegate: UserInfoPicker?
    private var languagePickerDelegates = [UserInfoPicker]()
    private var addLanguageButtons = [UIButton]()

    fileprivate var userInfo = [String: Any]()
    fileprivate var selectedLanguages = [UITextField:Language]()


    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.isHidden = true
        indicator.isHidden = true

        navigationItem.hidesBackButton = true

        configureCountryPicker()
        configureLanguagePicker(for: motherLanguageTextField)
        languageTextFields.append(motherLanguageTextField)
        configureBirthdayPicker()
        makeAnotherLanguageField()
        subscribeToNotifications()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeFromNotifications()
    }

    // MARK: - IBActions

    @IBAction private func submit(_ sender: Any) {
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
            userInfo[Key.Gender] = Gender.male.stringValue
        }

        guard !selectedLanguages.isEmpty else {
            warn(with: .notChosenMotherLanguage)
            return
        }

        var languages = [String:String]()
        selectedLanguages.filter { $0.value.name != .none && $0.value.level != .none }
            .forEach { languages[$0.value.name.stringValue] = $0.value.level.stringValue }
        userInfo[Key.Languages] = languages

        client.completeRegister(parameters: userInfo) { [weak self] response in
            guard let response = response, response == .success else {
                warn(with: .unknownError)
                return
            }
            
            SocialNetworkClient.Settings.registerComplete = true
            self?.dismiss(animated: true) {
                let viewController = self?.storyboard?.instantiateViewController(withIdentifier: UIStoryboard.Main.tabViewController)
                let window = (UIApplication.shared.delegate as! AppDelegate).window
                window?.rootViewController = viewController
                window?.makeKeyAndVisible()

                viewController?.view.alpha = 0
                UIView.animate(withDuration: 0.2) { viewController?.view.alpha = 1 }
            }
        }
    }

    @IBAction private func didSelectGender(_ sender: Any) {
        let index = genderSegmentedControl.selectedSegmentIndex
        guard let gender = Gender(rawValue: index + 1) else {
            return
        }

        userInfo[Key.Gender] = gender.stringValue
    }

    // MARK: - Private methods

    private func setUI(enabled: Bool) {
        DispatchQueue.main.async {
            self.submitButton.isEnabled = enabled
            self.submitButton.isHidden = !enabled
            self.indicator.isHidden = enabled
            self.warningLabel.isHidden = !enabled
            self.countryTextField.isEnabled = enabled
            self.birthdayTextField.isEnabled = enabled
            self.genderSegmentedControl.isEnabled = enabled

            self.languageTextFields.forEach { $0.isEnabled = enabled }
        }
    }

    func configureCountryPicker() {
        countryPicker = UIPickerView()
        countryPickerDelegate = UserInfoPicker(mode: .country)
        countryPickerDelegate?.delegate = self
        countryPicker?.delegate = countryPickerDelegate
        countryPicker?.dataSource = countryPickerDelegate
        countryTextField.inputView = countryPicker
    }

    func configureLanguagePicker(for textField: UITextField) {
        let languagePicker = UIPickerView()
        let languagePickerDelegate = UserInfoPicker(mode: .language)
        languagePickerDelegate.delegate = self
        languagePicker.delegate = languagePickerDelegate
        languagePicker.dataSource = languagePickerDelegate

        languagePickers.append(languagePicker)
        languagePickerDelegates.append(languagePickerDelegate)

        textField.inputView = languagePicker
    }

    func configureBirthdayPicker() {
        birthdayPicker = UIDatePicker()
        birthdayPicker?.datePickerMode = .date
        birthdayPicker?.maximumDate = Date()
        birthdayTextField.inputView = birthdayPicker
    }

    func makeAnotherLanguageField() {
        DispatchQueue.main.async {
            let stackView = UIStackView()
            stackView.distribution = .fillProportionally

            let textField = UITextField()
            textField.placeholder = "Another Language"
            textField.borderStyle = .roundedRect
            textField.font = self.countryTextField.font
            self.configureLanguagePicker(for: textField)

            self.languageTextFields.append(textField)
            stackView.addArrangedSubview(textField)

            let button = UIButton(type: .system)
            button.setTitle("+", for: .normal)
            button.addTarget(self, action: #selector(self.didAddAnotherLanguage(_:)), for: .touchUpInside)

            self.addLanguageButtons.last?.isEnabled = false
            if self.languageTextFields.count > 3 {
                button.isEnabled = false
            } else {
                self.addLanguageButtons.append(button)
            }

            stackView.addArrangedSubview(button)
            self.languagesStackView.addArrangedSubview(stackView)
        }
    }

    func subscribeToNotifications() {
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

    // MARK: - Notifications handlers

    @objc func didSelectBirthday(_ sender: Any) {
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

    @objc func didAddAnotherLanguage(_ sender: Any) {
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

// MARK: - UserInfoPickerDelegate protocol

extension CompleteRegisterViewController: UserInfoPickerDelegate {

    func userInfoPicker(_ picker: UserInfoPicker, pickedType type: UserInfoPicker.PickedType) {
        switch type {
        case .country(let country):
            countryTextField.text = country.localized
            userInfo[Key.Country] = country.stringValue

        case .language(let language):
            languageTextFields.filter { $0.isFirstResponder }.forEach {
                $0.text = language.name.localized
                selectedLanguages[$0] = language
            }
        }
    }

}
