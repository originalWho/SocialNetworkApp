import Alamofire

// MARK: - Messages

extension SocialNetworkClient {

    enum ReceiveMode {
        case latest
        case all
    }

    func send(message:String, to: String, completion: @escaping (String) -> Void) {

    }

    func send(status: String, for messageID: String, to: String, completion: @escaping (String) -> Void) {

    }

    func receive(messages: ReceiveMode, completion: @escaping (String) -> Void) {

    }

    func receive(messages: ReceiveMode, from: String, completion: @escaping (String) -> Void) {

    }
    
}

// MARK: - Friends

extension SocialNetworkClient {

    func getFriendList(completion: @escaping (String) -> Void) {

    }

    func friend(_ user: String, completion: @escaping (String) -> Void) {

    }

    func unfriend(_ user: String, completion: @escaping (String) -> Void) {

    }

    func block(_ user: String, completion: @escaping (String) -> Void) {

    }

    func unblock(_ user: String, completion: @escaping (String) -> Void) {
        
    }

}
