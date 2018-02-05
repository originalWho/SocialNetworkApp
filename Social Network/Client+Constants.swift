
struct ClientConstants {
    
    // MARK: - Constants
    
    struct Constants {
        static let APIScheme = "https"
        static let APIHost = "10.20.12.138"
        static let APIPort = 8443
        static let APIPath = "/api"
        static let OAuthPath = "/oauth"
    }
    
    struct OAuth {
        
        enum GrantType {
            case code
            case implicit
            case clientCredentials
            case password
        }
        
        enum Service {
            case facebook
            case google
        }
        
        struct ParameterKeys {
            static let ClientID = "client_id"
            static let ClientSecret = "client_secret"
            static let AuthorizeURI = "authorize_uri"
            static let TokenURI = "token_uri"
            static let Scope = "scope"
            static let RedirectURIs = "redirect_uris"
            static let SecretInBody = "secret_in_body"
            static let Verbose = "verbose"
            static let Username = "username"
            static let Password = "password"
            static let GrantType = "grant_type"
            static let Service = "service"
        }
        
        struct ParameterValuesGoogle {
            static let ClientID = "GOOGLE_CLIENT_ID"
            static let AuthorizeURI = "https://accounts.google.com/o/oauth2/auth"
            static let TokenURI = "https://www.googleapis.com/oauth2/v3/token"
            static let Scope = "profile"
        }
        
        struct ParameterValuesFacebook {
            
        }
        
        struct ParameterValuesDefault {
            static let ClientID = "clientapp"
            static let ClientSecret = "clientsecret"
            static let AuthorizeURI = "\(Constants.APIScheme)://\(Constants.APIHost):\(Constants.APIPort)\(Constants.OAuthPath)\(Methods.accessToken)"
        }
    }
    
    // MARK: - Methods
    
    struct Methods {

        static var accessToken: String {
            return "/token"
        }

        static var register: String {
            return "/register"
        }

        static var login: String {
            return "/login"
        }

        static var logout: String {
            return "/logout"
        }

        // MARK: - Profile

        struct Profile {

            private static var profile: String {
                return "/profile"
            }

            static var edit: String {
                return profile + "/edit"
            }

            static var me: String {
                return profile + "/me"
            }

            static var byID: String {
                return profile + "/%d"
            }

            static var add: String {
                return profile + "/%d/add"
            }

            static var remove: String {
                return profile + "/%d/delete"
            }

            static var block: String {
                return profile + "/%d/block"
            }

            static var unblock: String {
                return profile + "/%d/unblock"
            }

            static var friends: String {
                return profile + "/%d/friends"
            }

            static var subscribers: String {
                return profile + "/%d/subscribers"
            }

            static var subscriptions: String {
                return profile + "/%d/subscriptions"
            }

            static var blacklist: String {
                return profile + "/blacklist"
            }

        }

        // MARK: - Conversation

        struct Conversation {

            static var message: String {
                return "/message"
            }

            static var conversations: String {
                return "/conversations"
            }

            struct Key {

                static var id: String {
                    return "id"
                }

                static var offset: String {
                    return "offset"
                }

                static var count: String {
                    return  "count"
                }

            }

        }

        // MARK: - Search

        struct Search {

            static var path: String {
                return "/search"
            }

            struct Key {

                static var offset: String {
                    return "offset"
                }

                static var count: String {
                    return "count"
                }

            }

        }
        
    }
    
    // MARK: - Parameters
    
    struct ParameterKeys {
        static let ID = "id"
        static let Name = "name"
        static let Email = "email"
        static let Password = "password"
        static let PhotoLink = "photoLink"
        static let HasPhoto = "hasPhoto"
        static let Birthday = "birthday"
        static let Age = "age"
        static let Country = "country"
        static let Gender = "gender"
        static let Languages = "languages"
        static let About = "about"
        static let Online = "online"
        static let senderID = "senderId"
        static let datetime = "datetime"
        static let messageType = "messageType"
        static let messageDataType = "messageDataType"
        static let data = "data"
        static let startPosition = "startPosition"
        static let endPosition = "endPosition"
        static let parentID = "parentId"
    }

    // MARK: - Enums

    enum ServerResponse: Int {
        case success
        case emailExists
        case incorrectData
        case incorrectPassword
        case userNotFound
        case accessDenied
        case unknownError
    }

    enum SendRequest {
        case fail(ServerResponse)
        case success
    }

    enum ReceiveMode {
        case latest(Int, Int)
        case all
    }

    enum MessagesRequest {
        case fail(ServerResponse)
        case success([Message])
    }

    enum ConversationsRequest {
        case fail(ServerResponse)
        case success([Conversation])
    }

    enum ActionRequest {
        case fail(ServerResponse)
        case success
    }

    enum ProfileRequest {
        case fail(ServerResponse)
        case success(User)
    }

    enum UserListRequest {
        case fail(ServerResponse)
        case success([User])
    }
    
}
