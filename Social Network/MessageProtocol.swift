import Foundation

typealias UserID = UInt64
typealias MessageID = UInt64

enum MessageStatus: Int {
    case sent
    case delivered
}

enum MessageType: Int {
    case plain
    case comment
}

enum MessageDataType: Int {
    case text
    case image
    case audio
}

protocol MessageProtocol: Storable {

    var id: MessageID? { get }
    var senderID: UserID { get }
    var date: Date { get }
    var data: Data { get }
    var dataType: MessageDataType { get }
    var type: MessageType { get }
    var status: MessageStatus { get set }
    var json: [String:Any] { get }

    init?(from json: [String:Any])

}

protocol CommentProtocol: MessageProtocol {

    var parentID: MessageID? { get }
    var startPosition: Int { get }
    var endPosition: Int { get }
    
}
