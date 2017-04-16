import Foundation

extension SocialNetworkClient {

    struct Settings {
        /*
        static var launchedFirstTime: Bool {
            get {

            }

            set {

            }
        }

        static var signedIn: Bool {
            get {

            }

            set {

            }
        }

        static var registerComplete: Bool {
            get {

            }

            set {
                
            }
        }
        */
    }

}

fileprivate struct ParameterKey {

    static let launchedFirstTime = "client.userDefaults.launchedFirstTime"
    static let signedIn = "client.userDefaults.signedIn"
    static let registerComplete = "client.userDefaults.registerComplete"

}

fileprivate extension UserDefaults {

    private static let suiteName = "hse.socialNetwork.client"
    static var clientDefaults: UserDefaults? = UserDefaults(suiteName: suiteName)

}

fileprivate extension UserDefaults {

    var launchedFirstTime: Bool {
        get {
            return (value(forKey: ParameterKey.launchedFirstTime) as? Bool) ?? true
        }

        set {
            set(newValue, forKey: ParameterKey.launchedFirstTime)
        }
    }

    var signedIn: Bool {
        get {
            return (value(forKey: ParameterKey.signedIn) as? Bool) ?? false
        }

        set {
            set(newValue, forKey: ParameterKey.signedIn)
        }
    }

    var registerComplete: Bool {
        get {
            return (value(forKey: ParameterKey.registerComplete) as? Bool) ?? false
        }

        set {
            set(newValue, forKey: ParameterKey.registerComplete)
        }
    }

}
