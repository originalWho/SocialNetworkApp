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

    }

}

fileprivate struct ParameterKey {

    static var launchedFirstTime: String { return "hse.socialNetwork.client.launchedFirstTime" }
    static var signedIn: String { return "hse.socialNetwork.client.signedIn" }
    static var registerComplete: String { return "hse.socialNetwork.client.registerComplete" }
    static var username: String { return "hse.socialNetwork.client.username" }
    static var password: String { return "hse.socialNetwork.client.password" }

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

}
