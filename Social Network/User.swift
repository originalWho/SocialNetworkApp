import Foundation

struct User: Storable {

    let id: UserID
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
        return id.hashValue
    }

    init(id: UserID, name: String? = nil, email: String?, age: Int?, gender: Gender? = Gender.none,
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

        self.id = (json[Key.ID] as? UserID) ?? 0
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
        return lhs.id < rhs.id
    }

    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }

}
