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

    }

}

fileprivate struct ParameterKey {

    static let launchedFirstTime = "hse.socialNetwork.client.launchedFirstTime"
    static let signedIn = "hse.socialNetwork.client.signedIn"
    static let registerComplete = "hse.socialNetwork.client.registerComplete"

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
            return bool(forKey: ParameterKey.launchedFirstTime) 
        }

        set {
            set(newValue, forKey: ParameterKey.launchedFirstTime)
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

}
