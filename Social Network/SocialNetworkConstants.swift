//
//  SocialNetworkConstants.swift
//  Social Network
//
//  Created by Arthur Davletshin on 2/12/17.
//  Copyright © 2017 hse. All rights reserved.
//

import Foundation

extension SocialNetworkClient {
    
    // MARK: Constants
    
    struct Constants {
        static let APIScheme = "http"
        static let APIHost = "localhost"
        static let APIPort = 8080
        static let APIPath = "/api"
    }
    
    // MARK: Methods
    
    struct Methods {
        static let Register = "/register"
        static let Login = "/login"
        static let Logout = "/logout"
    }
    
    // MARK: Parameters
    
    struct ParameterKeys {
        static let Name = "name"
        static let Email = "email"
        static let Password = "password"
        static let Photo = "photoLink"
        static let Age = "age"
        static let Country = "country"
        static let Gender = "gender"
        static let About = "about"
        static let Online = "online"
    }
    
    struct ParameterValues {
        
    }
    
    // MARK: HTTP
    
    struct HTTP {
        struct Methods {
            static let Get = "GET"
            static let Post = "POST"
            static let Delete = "DELETE"
            static let Put = "PUT"
        }
        struct Headers {
            static let Accept = "Accept"
            static let ContentType = "Content-Type"
        }
        struct Types {
            static let JSON = "application/json"
        }
    }
}
