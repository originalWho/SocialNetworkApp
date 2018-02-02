import Foundation

extension SocialNetworkClient {

    private typealias defaults = UserDefaults.ClientSuite

    struct Settings {

        static var launchedFirstTime: Bool {
            get {
                return defaults().launchedFirstTime
            }

            set {
                defaults().launchedFirstTime = newValue
            }
        }

        static var signedIn: Bool {
            get {
                return defaults().signedIn
            }

            set {
                defaults().signedIn = newValue
            }
        }

        static var registerComplete: Bool {
            get {
                return defaults().registerComplete
            }

            set {
                defaults().registerComplete = newValue
            }
        }

        static var username: String? {
            get {
                return defaults().username
            }

            set {
                defaults().username = newValue
            }
        }

        static var password: String? {
            get {
                return defaults().password
            }

            set {
                defaults().password = newValue
            }
        }

        static var userId: Int? {
            get {
                return defaults().userId
            }

            set {
                defaults().userId = newValue
            }
        }

        static var searchParameters: SearchParameters {
            get {
                return defaults().searchParamters
            }

            set {
                defaults().searchParamters = newValue
            }
        }
        
    }

}

fileprivate struct ParameterKey {

    static var launchedFirstTime: String { return "hse.socialNetwork.client.launchedFirstTime" }
    static var signedIn: String { return "hse.socialNetwork.client.signedIn" }
    static var registerComplete: String { return "hse.socialNetwork.client.registerComplete" }
    static var username: String { return "hse.socialNetwork.client.username" }
    static var password: String { return "hse.socialNetwork.client.password" }
    static var userId: String { return "hse.socialNetwork.client.userId" }
    static var countrySearchParameter: String { return "hse.socialNetwork.searchParameter.country" }
    static var genderSearchParameter: String { return "hse.socialNetwork.searchParameter.gender" }
    static var languagesSearchParameter: String { return "hse.socialNetwork.searchParameter.languages" }
    static var onlineSearchParameter: String { return "hse.socialNetwork.searchParameter.online" }
    static var withPhotoSearchParameter: String { return "hse.socialNetwork.searchParameter.withPhoto" }

}

fileprivate extension UserDefaults {

    class ClientSuite: UserDefaults {

        private let suiteName = "hse.socialNetwork.client"

        init() {
            super.init(suiteName: suiteName)!
        }

    }

}

fileprivate extension UserDefaults.ClientSuite {

    var launchedFirstTime: Bool {
        get {
            return !bool(forKey: ParameterKey.launchedFirstTime)
        }

        set {
            set(!newValue, forKey: ParameterKey.launchedFirstTime)
        }
    }

    var signedIn: Bool {
        get {
            return bool(forKey: ParameterKey.signedIn)
        }

        set {
            set(newValue, forKey: ParameterKey.signedIn)
        }
    }

    var registerComplete: Bool {
        get {
            return bool(forKey: ParameterKey.registerComplete)
        }

        set {
            set(newValue, forKey: ParameterKey.registerComplete)
        }
    }

    var username: String? {
        get {
            return string(forKey: ParameterKey.username)
        }

        set {
            set(newValue, forKey: ParameterKey.username)
        }
    }

    var password: String? {
        get {
            return string(forKey: ParameterKey.password)
        }

        set {
            set(newValue, forKey: ParameterKey.password)
        }
    }

    var userId: Int? {
        get {
            return integer(forKey: ParameterKey.userId)
        }

        set {
            set(newValue, forKey: ParameterKey.userId)
        }
    }

    var searchParamters: SearchParameters {
        get {
            var searchParameters = SearchParameters()

            let countryRawValue = integer(forKey: ParameterKey.countrySearchParameter)
            searchParameters.country = Country(rawValue: countryRawValue) ?? .none

            let genderRawValue = integer(forKey: ParameterKey.genderSearchParameter)
            searchParameters.gender = Gender(rawValue: genderRawValue) ?? .none

            if let languages = object(forKey: ParameterKey.languagesSearchParameter) as? [Int] {
                searchParameters.languageNames = languages.flatMap { LanguageName(rawValue: $0) }
            }

            searchParameters.online = bool(forKey: ParameterKey.onlineSearchParameter)
            searchParameters.withPhoto = bool(forKey: ParameterKey.withPhotoSearchParameter)

            return searchParameters
        }

        set {
            var keyedValues = [String: Any]()
            keyedValues[ParameterKey.countrySearchParameter] = newValue.country.rawValue
            keyedValues[ParameterKey.genderSearchParameter] = newValue.gender.rawValue
            keyedValues[ParameterKey.languagesSearchParameter] = newValue.languageNames.map { $0.rawValue }
            keyedValues[ParameterKey.onlineSearchParameter] = newValue.online
            keyedValues[ParameterKey.withPhotoSearchParameter] = newValue.withPhoto
            setValuesForKeys(keyedValues)
        }
    }

}
