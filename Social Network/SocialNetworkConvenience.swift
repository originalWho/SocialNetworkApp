//
//  SocialNetworkConvenience.swift
//  Social Network
//
//  Created by Arthur Davletshin on 2/12/17.
//  Copyright © 2017 hse. All rights reserved.
//

import Foundation

extension SocialNetworkClient {
    func register(parameters: [String:AnyObject], completion: @escaping (_ result: AnyObject?, _ error: Error?) -> Void) {
        let registerURL = url(from: nil, method: Methods.Register)
        _ = taskForPOSTMethod(url: registerURL, jsonBody: parameters, completion: { (result, error) in
            completion(result, error)
        })
    }
    
    func authenticate(parameters: [String:AnyObject], completion: @escaping (_ result: AnyObject, _ error: Error) -> Void) {
        
    }
    
    func url(from parameters: [String:AnyObject]?, method: String) -> URL {
        var components = URLComponents()
        components.scheme = Constants.APIScheme
        components.host = Constants.APIHost
        components.port = Constants.APIPort
        components.path = Constants.APIPath
        components.path.append(method)
        
        if parameters != nil {
            components.queryItems = [URLQueryItem]()
            for (key, value) in parameters! {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems?.append(queryItem)
            }
        }
        return components.url!
    }
}
