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

struct Message {

    enum Status: Int {
        case delivered
        case read
        case sent
    }

    enum ContentType: Int {
        case text
    }

    var id: Int?
    let senderId: Int
    let recipientId: Int
    let datetime: Date
    var status: Status
    let data: Data
    let contentType: ContentType

    init(with senderId: Int, recipientId: Int, date: Date? = Date(), data: Data, and type: ContentType) {
        self.senderId = senderId
        self.recipientId = recipientId
        self.datetime = date!
        self.status = .sent
        self.data = data
        self.contentType = type
    }

    var json: [String:Any] {
        var json = [String:Any]()
        json["senderId"] = senderId
        json["recipientId"] = recipientId
        json["datetime"] = datetime
        json["status"] = status.rawValue
        json["data"] = data
        json["contentType"] = contentType.rawValue

        return json
    }

}

// MARK: - User

struct User {
    let id: Int?
    let name: String?
    let email: String?
    let age: Int?
    let gender: Gender?
    let about: String?
    let country: Country?
    let languages: [Language]?
    let photoLink: URL?
    let online: Bool?

    init(id: Int?, name: String? = nil, email: String?, age: Int?, gender: Gender? = Gender.None,
         about: String? = nil, country: Country? = Country.None, languages: Language..., photoLink: URL? = nil, online: Bool?) {
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

    private typealias Key = SocialNetworkClient.ParameterKeys

    init?(from json: [String:Any]) {
        guard let id = json[Key.ID] as? Int,
            let gender = json[Key.Gender] as? String,
            let country = json[Key.Country] as? String,
            let email = json[Key.Email] as? String,
            //let age = json[Key.Age] as? Int,
            //let photoLink = json[Key.Photo] as? String,
            let languagesDict = json[Key.Languages] as? [String:String] else {
                return nil
        }

        var languages = [Language]()
        languagesDict.forEach{
            languages.append(Language(with: LanguageName(stringValue: $0.key),
                                      and: LanguageLevel(stringValue: $0.value)))
        }
        languages.sort { $0.0.level.rawValue > $0.1.level.rawValue }

        self.id = id
        self.name = (json[Key.Name] as? String)
        self.email = email
        self.age = 20
        self.gender = Gender(stringValue: gender)
        self.about = json[Key.About] as? String
        self.country = Country(stringValue: country)
        self.languages = languages
        self.photoLink = nil
        self.online = false
    }
    
}
