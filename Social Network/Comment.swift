import Foundation

struct Comment: CommentProtocol {

    var id: MessageID?
    let parentID: MessageID
    let senderID: UserID
    let startPosition: Int
    let endPosition: Int
    let date: Date
    let data: Data
    let dataType: MessageDataType
    let type: MessageType
    var status: MessageStatus

    var hashValue: Int {
        return data.hashValue ^ date.hashValue ^ senderID.hashValue
    }

    private typealias Key = ClientConstants.ParameterKeys

    private static let dateFormatter: ISO8601DateFormatter = {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = .withInternetDateTime
        return dateFormatter
    }()

    var json: [String:Any] {
        var json = [String:Any]()
        json[Key.senderID] = senderID
        json[Key.datetime] = Comment.dateFormatter.string(from: date)
        json[Key.data] = data.base64EncodedString()
        json[Key.messageType] = type.stringValue
        json[Key.messageDataType] = dataType.stringValue
        json[Key.startPosition] = startPosition
        json[Key.endPosition] = endPosition
        json[Key.parentID] = parentID
        return json
    }

    init(senderID: UserID, date: Date = Date(), data: Data, dataType: MessageDataType,
         startPosition: Int, endPosition: Int, messageID: MessageID) {
        self.senderID = senderID
        self.date = date
        self.status = .sent
        self.data = data
        self.dataType = dataType
        self.type = .comment
        self.startPosition = startPosition
        self.endPosition = endPosition
        self.parentID = messageID
    }

    init?(from json: [String:Any]) {
        guard let messageTypeString = json[Key.messageType] as? String,
            let type = MessageType(stringValue: messageTypeString),
            type == .comment else {
                return nil
        }
        
        guard let id = json[Key.ID] as? MessageID else {
            return nil
        }

        guard let senderID = json[Key.senderID] as? UserID else {
            return nil
        }

        guard let datetime = json[Key.datetime] as? TimeInterval else {
            return nil
        }

        guard let messageDataTypeString = json[Key.messageDataType] as? String,
            let dataType = MessageDataType(stringValue: messageDataTypeString) else {
                return nil
        }

        guard let data64encoded = json[Key.data] as? String else {
            return nil
        }

        guard let data = Data(base64Encoded: data64encoded) else {
            return nil
        }

        guard let parentID = json[Key.parentID] as? MessageID else {
            return nil
        }

        guard let startPosition = json[Key.startPosition] as? Int else {
            return nil
        }

        guard let endPosition = json[Key.endPosition] as? Int else {
            return nil
        }

        self.id = id
        self.senderID = senderID
        self.date = Date(timeIntervalSince1970: datetime)
        self.data = data
        self.status = .delivered
        self.dataType = dataType
        self.type = type
        self.parentID = parentID
        self.startPosition = startPosition
        self.endPosition = endPosition
    }

    static func <(lhs: Comment, rhs: Comment) -> Bool {
        if let lhsID = lhs.id, let rhsID = rhs.id {
            return lhsID < rhsID && lhs.senderID < rhs.senderID
                && (lhs.startPosition - lhs.endPosition) < (lhs.startPosition - rhs.endPosition)
        }
        else {
            return lhs.senderID < rhs.senderID
                && (lhs.startPosition - lhs.endPosition) < (lhs.startPosition - rhs.endPosition)
        }
    }

    static func ==(lhs: Comment, rhs: Comment) -> Bool {
        return lhs.data == rhs.data
            && lhs.senderID == rhs.senderID
            && lhs.startPosition == rhs.startPosition
            && lhs.endPosition == rhs.endPosition
    }


}
