import UIKit

class UserInfoPicker: NSObject {

    // MARK: - Enum

    enum PickerType {
        case country
        case language
    }

    fileprivate enum PickLanguage: Int {
        case name
        case level
    }

    // MARK: - Properties

    let type: PickerType
    fileprivate var pickedCountry: Country
    fileprivate var pickedLanguageName: LanguageName
    fileprivate var pickedLanguageLevel: LanguageLevel

    init(type: PickerType) {
        self.type = type
        pickedCountry = .None
        pickedLanguageName = .None
        pickedLanguageLevel = .None
    }

}

// MARK: - UIPickerViewDelegate protocol

extension UserInfoPicker: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch type {
        case .country:
            return country(value: row).stringValue

        case .language:
            switch component {
            case PickLanguage.name.rawValue:
                return languageName(value: row).stringValue

            case PickLanguage.level.rawValue:
                return languageLevel(value: row).stringValue

            default:
                return nil
            }
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch type {
        case .country:
            pickedCountry = country(value: row)
            NotificationCenter.default.post(name: .UICountryPicked, object: pickedCountry)

        case .language:
            switch component {
            case PickLanguage.name.rawValue:
                pickedLanguageName = languageName(value: row)

            case PickLanguage.level.rawValue:
                pickedLanguageLevel = languageLevel(value: row)

            default:
                return
            }

            guard pickedLanguageName != .None, pickedLanguageLevel != .None else {
                return
            }

            let language = Language(with: pickedLanguageName, and: pickedLanguageLevel)
            NotificationCenter.default.post(name: .UILanguagePicked, object: language)
        }
    }

}

// MARK: - UIPickerViewDataSource protocol

extension UserInfoPicker: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch type {
        case .country:
            return 1

        case .language:
            return 2
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch type {
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
            return .None
        }

        return country
    }

    func languageName(value: Int) -> LanguageName {
        guard let languageName = LanguageName(rawValue: value + 1) else {
            return .None
        }

        return languageName
    }

    func languageLevel(value: Int) -> LanguageLevel {
        guard let languageLevel = LanguageLevel(rawValue: value + 1) else {
            return .None
        }
        
        return languageLevel
    }
    
}
