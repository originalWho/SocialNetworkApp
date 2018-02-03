import Foundation

// MARK: - Language

struct Language {
    let name: LanguageName
    let level: LanguageLevel
    var dictionary: [String:Int] {
        return ["\(name.rawValue)":level.rawValue]
    }

    init(with name: LanguageName, and level: LanguageLevel) {
        self.name = name
        self.level = level
    }
}

// MARK: - Message

typealias UserID = UInt64
typealias MessageID = UInt64

struct Message: Storable {

    enum Status: Int {
        case sent
        case delivered
    }

    enum MessageType: Int {
        case plain
        case comment
    }

    enum DataType: Int {
        case text
        case image
        case audio
    }

    var id: MessageID?
    let senderId: UserID
    let date: Date
    let data: Data
    let dataType: DataType
    let type: MessageType
    var status: Status

    var hashValue: Int {
        return data.hashValue ^ senderId.hashValue
    }

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }()

    init(senderId: UserID, date: Date = Date(), data: Data, dataType: DataType, type: MessageType) {
        self.senderId = senderId
        self.date = date
        self.status = .sent
        self.data = data
        self.dataType = dataType
        self.type = type
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
            let type = Message.MessageType(stringValue: messageTypeString) else {
                return nil
        }

        guard let messageDataTypeString = json[Key.messageDataType] as? String,
            let dataType = Message.DataType(stringValue: messageDataTypeString) else {
                return nil
        }

        guard let data64encoded = json[Key.data] as? String else {
            return nil
        }

        guard let data = Data(base64Encoded: data64encoded) else {
            return nil
        }

        self.id = id
        self.senderId = senderID
        self.date = Date(timeIntervalSince1970: datetime)
        self.data = data
        self.status = .delivered
        self.dataType = dataType
        self.type = type
    }

    private typealias Key = ClientConstants.ParameterKeys

    var json: [String:Any] {
        var json = [String:Any]()
        json[Key.senderID] = senderId
        json[Key.datetime] = Message.dateFormatter.string(from: date)
        json[Key.data] = data.base64EncodedString()
        json[Key.messageType] = type.stringValue
        json[Key.messageDataType] = dataType.stringValue
        return json
    }

    static func <(lhs: Message, rhs: Message) -> Bool {
        if let lhsID = lhs.id, let rhsID = rhs.id {
            return lhsID < rhsID && lhs.senderId < rhs.senderId
        }
        else {
            return lhs.senderId < rhs.senderId
        }
    }

    static func ==(lhs: Message, rhs: Message) -> Bool {
        return lhs.data == rhs.data && lhs.senderId == rhs.senderId
    }

}

// MARK: - User

struct User: Storable {

    let id: UserID?
    let name: String?
    let email: String?
    let age: Int?
    let gender: Gender?
    let about: String?
    let country: Country?
    let languages: [Language]?
    let photoLink: URL?
    let online: Bool?

    var hashValue: Int {
        return id?.hashValue ?? 0
    }

    init(id: UserID?, name: String? = nil, email: String?, age: Int?, gender: Gender? = Gender.none,
         about: String? = nil, country: Country? = Country.none, languages: [Language]?, photoLink: URL? = nil, online: Bool?) {
        self.id = id
        self.name = name
        self.email = email
        self.age = age
        self.gender = gender
        self.about = about
        self.country = country
        self.languages = languages
        self.photoLink = photoLink
        self.online = online
    }

    private typealias Key = ClientConstants.ParameterKeys

    init(from json: [String:Any]) {
        var languages = [Language]()
        let languagesDict = json[Key.Languages] as? [String:String]
        languagesDict?.forEach{
            languages.append(Language(with: LanguageName(stringValue: $0.key),
                                      and: LanguageLevel(stringValue: $0.value)))
        }
        languages.sort { $0.level.rawValue > $1.level.rawValue }

        let gender = (json[Key.Gender] as? String) ?? String.Server.Gender.None
        let country = (json[Key.Country] as? String) ?? String.Server.Country.None
        let photoLink = (json[Key.PhotoLink] as? String) ?? ""
        let online = (json[Key.Online] as? Int) ?? 0

        self.id = json[Key.ID] as? UserID
        self.name = (json[Key.Name] as? String)
        self.email = json[Key.Email] as? String
        self.age = json[Key.Age] as? Int
        self.gender = Gender(stringValue: gender)
        self.about = json[Key.About] as? String
        self.country = Country(stringValue: country)
        self.languages = languages
        self.photoLink = URL(string: photoLink)
        self.online = (online == 1)
    }

    static func <(lhs: User, rhs: User) -> Bool {
        if let lhsID = lhs.id, let rhsID = rhs.id {
            return lhsID < rhsID
        }

        return true
    }

    static func ==(lhs: User, rhs: User) -> Bool {
        if let lhsID = lhs.id, let rhsID = rhs.id {
            return lhsID == rhsID
        }

        return false
    }

}
