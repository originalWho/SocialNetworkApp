import UIKit

protocol UserInfoPickerDelegate: class {
    func userInfoPicker(_ picker: UserInfoPicker, pickedType type: UserInfoPicker.PickedType)
}

final class UserInfoPicker: NSObject {

    // MARK: - Public types

    enum Mode {
        case country
        case language
    }

    enum PickedType {
        case country(Country)
        case language(Language)
    }

    // MARK: - Private types

    fileprivate enum PickLanguage: Int {
        case name
        case level
    }

    // MARK: - Public properties

    weak var delegate: UserInfoPickerDelegate?

    // MARK: - Private properties

    fileprivate let mode: Mode
    fileprivate var pickedCountry: Country
    fileprivate var pickedLanguageName: LanguageName
    fileprivate var pickedLanguageLevel: LanguageLevel

    // MARK: - Init

    init(mode: Mode) {
        self.mode = mode
        pickedCountry = .afghanistan
        pickedLanguageName = .afrikaans
        pickedLanguageLevel = .beginner
    }

}

// MARK: - UIPickerViewDelegate protocol

extension UserInfoPicker: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch mode {
        case .country:
            return country(value: row).localized

        case .language:
            switch component {
            case PickLanguage.name.rawValue:
                return languageName(value: row).localized

            case PickLanguage.level.rawValue:
                return languageLevel(value: row).localized

            default:
                return nil
            }
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch mode {
        case .country:
            pickedCountry = country(value: row)
            delegate?.userInfoPicker(self, pickedType: .country(pickedCountry))

        case .language:
            switch component {
            case PickLanguage.name.rawValue:
                pickedLanguageName = languageName(value: row)

            case PickLanguage.level.rawValue:
                pickedLanguageLevel = languageLevel(value: row)

            default:
                return
            }

            let pickedLanguage = Language(with: pickedLanguageName, and: pickedLanguageLevel)
            delegate?.userInfoPicker(self, pickedType: .language(pickedLanguage))
        }
    }

}

// MARK: - UIPickerViewDataSource protocol

extension UserInfoPicker: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch mode {
        case .country:
            return 1

        case .language:
            return 2
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch mode {
        case .country:
            return Country.count

        case .language:
            switch component {
            case PickLanguage.name.rawValue:
                return LanguageName.count

            case PickLanguage.level.rawValue:
                return LanguageLevel.count

            default:
                return 0
            }
        }
    }

}

// MARK: - Private methods

fileprivate extension UserInfoPicker {

    func country(value: Int) -> Country {
        guard let country = Country(rawValue: value + 1) else {
            return .none
        }

        return country
    }

    func languageName(value: Int) -> LanguageName {
        guard let languageName = LanguageName(rawValue: value + 1) else {
            return .none
        }

        return languageName
    }

    func languageLevel(value: Int) -> LanguageLevel {
        guard let languageLevel = LanguageLevel(rawValue: value + 1) else {
            return .none
        }
        
        return languageLevel
    }
    
}
