
extension SocialNetworkClient {
    
    // MARK: - Constants
    
    struct Constants {
        static let APIScheme = "https"
        static let APIHost = "localhost"
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
            static let AuthorizeURI = "\(Constants.APIScheme)://\(Constants.APIHost):\(Constants.APIPort)\(Constants.OAuthPath)\(Methods.AccessToken)"
        }
    }
    
    // MARK: - Methods
    
    struct Methods {
        static let AccessToken = "/token"
        static let Register = "/register"
        static let Login = "/login"
        static let Logout = "/logout"

        struct Profile {
            static let Edit = "/profile/edit"
            static let Me = "/profile/me"
            static let ByID = "/profile/%d"
            static let Add = "/profile/%d/add"
            static let Remove = "/profile/%d/delete"
            static let Block = "/profile/%d/block"
            static let Unblock = "/profile/%d/unblock"
            static let Friends = "/profile/%d/friends"
            static let Subscribers = "/profile/%d/subscribers"
            static let Subscriptions = "/profile/%d/subscriptions"
            static let Blacklist = "/profile/blacklist"
        }

        struct Conversation {
            static let Messages = "/messages"
            static let SendMessageTo = "/messages/%d"

            struct Key {
                static let ID = "id"
                static let Offset = "offset"
                static let Count = "count"
            }
        }

        struct Search {
            static let Path = "/search"

            struct Key {
                static let Offset = "offset"
                static let Count = "count"
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

}
