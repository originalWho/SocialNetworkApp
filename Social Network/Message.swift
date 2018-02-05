import Foundation

struct Message: MessageProtocol {

    var id: MessageID?
    let senderID: UserID
    let date: Date
    let data: Data
    let dataType: MessageDataType
    let type: MessageType
    var status: MessageStatus

    var hashValue: Int {
        return data.hashValue ^ senderID.hashValue
    }

    private static let dateFormatter: ISO8601DateFormatter = {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = .withInternetDateTime
        return dateFormatter
    }()

    init(senderID: UserID, date: Date = Date(), data: Data, dataType: MessageDataType) {
        self.senderID = senderID
        self.date = date
        self.status = .sent
        self.data = data
        self.dataType = dataType
        self.type = .plain
    }

    init?(from json: [String:Any]) {
        guard let id = json[Key.ID] as? MessageID else {
            return nil
        }

        guard let senderID = json[Key.senderID] as? UserID else {
            return nil
        }

        guard let datetime = json[Key.datetime] as? TimeInterval else {
            return nil
        }

        guard let messageTypeString = json[Key.messageType] as? String,
            let type = MessageType(stringValue: messageTypeString),
            type == .plain else {
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

        self.id = id
        self.senderID = senderID
        self.date = Date(timeIntervalSince1970: datetime)
        self.data = data
        self.status = .delivered
        self.dataType = dataType
        self.type = type
    }

    private typealias Key = ClientConstants.ParameterKeys

    var json: [String:Any] {
        var json = [String:Any]()
        json[Key.senderID] = senderID
        json[Key.datetime] = Message.dateFormatter.string(from: date)
        json[Key.data] = data.base64EncodedString()
        json[Key.messageType] = type.stringValue
        json[Key.messageDataType] = dataType.stringValue
        return json
    }

    static func <(lhs: Message, rhs: Message) -> Bool {
        if let lhsID = lhs.id, let rhsID = rhs.id {
            return lhsID < rhsID && lhs.senderID < rhs.senderID
        }
        else {
            return lhs.senderID < rhs.senderID
        }
    }

    static func ==(lhs: Message, rhs: Message) -> Bool {
        return lhs.data == rhs.data && lhs.senderID == rhs.senderID
    }

}
