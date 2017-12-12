import Foundation
import OAuth2

fileprivate typealias OAuth = ClientConstants.OAuth
fileprivate typealias ParameterKey = ClientConstants.OAuth.ParameterKeys
fileprivate typealias DefaultValue = ClientConstants.OAuth.ParameterValuesDefault
fileprivate typealias GoogleValue = ClientConstants.OAuth.ParameterValuesGoogle


struct OAuthInstance {

    static var Default: OAuth2PasswordGrant {
        get {
            let settings = [
                ParameterKey.ClientID: DefaultValue.ClientID,
                ParameterKey.ClientSecret: DefaultValue.ClientSecret,
                ParameterKey.AuthorizeURI: DefaultValue.AuthorizeURI
            ]

            return OAuth2PasswordGrant(settings: settings)
        }
    }
    
    static var Google: OAuth2CodeGrant {
        get {
            let settings = [
                ParameterKey.ClientID: GoogleValue.ClientID,
                ParameterKey.AuthorizeURI: GoogleValue.AuthorizeURI,
                ParameterKey.TokenURI: GoogleValue.TokenURI,
                ParameterKey.Scope: GoogleValue.Scope
            ]

            return OAuth2CodeGrant(settings: settings)
        }
    }

}
