//
//  SocialNetworkClient.swift
//  Social Network
//
//  Created by Arthur Davletshin on 2/12/17.
//  Copyright © 2017 hse. All rights reserved.
//

import UIKit

class SocialNetworkClient: NSObject {
    
    // MARK: Properties
    
    var session = URLSession.shared
    var requestToken: String? = nil
    var sessionID: String? = nil
    var userID: Int? = nil
    
    func taskForGETMethod() {
        
    }
    
    func taskForPOSTMethod(url: URL, jsonBody: [String:AnyObject], completion: @escaping (_ result: AnyObject?, _ error: Error?) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: url)
        request.httpMethod = HTTP.Methods.Post
        request.addValue(HTTP.Types.JSON, forHTTPHeaderField: HTTP.Headers.Accept)
        request.addValue(HTTP.Types.JSON, forHTTPHeaderField: HTTP.Headers.ContentType)
        let json = try? JSONSerialization.data(withJSONObject: jsonBody)
        request.httpBody = json

        let task = session.dataTask(with: request) { (data, response, error) in
            func sendError(_ error: String) {
                print(error)
            }
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            guard data != nil else {
                sendError("No data was returned by the request!")
                return
            }
            completion(data as AnyObject?, nil)
        }
        
        task.resume()
        
        return task
    }
    
    // MARK: Shared Instance
    
    class func shared() -> SocialNetworkClient {
        struct Singleton {
            static var sharedInstance = SocialNetworkClient()
        }
        return Singleton.sharedInstance
    }
}
