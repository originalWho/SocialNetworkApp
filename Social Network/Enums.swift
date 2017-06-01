import Foundation

// MARK: - Gender

enum Gender: Int {

    case none
    case male
    case female

    static var count: Int {
        return Gender.female.rawValue + 1
    }

}

// MARK: - Country

enum Country: Int {

    case none
    case afghanistan
    case albania
    case algeria
    case andorra
    case angola
    case antiguaAndBarbuda
    case argentina
    case armenia
    case aruba
    case australia
    case austria
    case azerbaijan
    case bahamas
    case bahrain
    case bangladesh
    case barbados
    case belarus
    case belgium
    case belize
    case benin
    case bhutan
    case bolivia
    case bosniaAndHerzegovina
    case botswana
    case brazil
    case brunei
    case bulgaria
    case burkinaFaso
    case burma
    case burundi
    case cambodia
    case cameroon
    case canada
    case caboVerde
    case centralAfricanRepublic
    case chad
    case chile
    case china
    case colombia
    case comoros
    case costaRica
    case cotedIvoire
    case croatia
    case cuba
    case curacao
    case cyprus
    case czechia
    case democraticRepublicOfTheCongo
    case denmark
    case djibouti
    case dominica
    case dominicanRepublic
    case ecuador
    case egypt
    case elSalvador
    case equatorialGuinea
    case eritrea
    case estonia
    case ethiopia
    case fiji
    case finland
    case france
    case gabon
    case gambia
    case georgia
    case germany
    case ghana
    case greece
    case grenada
    case guatemala
    case guinea
    case guineaBissau
    case guyana
    case haiti
    case holySee
    case honduras
    case hongKong
    case hungary
    case iceland
    case india
    case indonesia
    case iran
    case iraq
    case ireland
    case israel
    case italy
    case jamaica
    case japan
    case jordan
    case kazakhstan
    case kenya
    case kiribati
    case kosovo
    case kuwait
    case kyrgyzstan
    case laos
    case latvia
    case lebanon
    case lesotho
    case liberia
    case libya
    case liechtenstein
    case lithuania
    case luxembourg
    case macau
    case macedonia
    case madagascar
    case malawi
    case malaysia
    case maldives
    case mali
    case malta
    case marshallIslands
    case mauritania
    case mauritius
    case mexico
    case micronesia
    case moldova
    case monaco
    case mongolia
    case montenegro
    case morocco
    case mozambique
    case namibia
    case nauru
    case nepal
    case netherlands
    case newZealand
    case nicaragua
    case niger
    case nigeria
    case northKorea
    case norway
    case oman
    case pakistan
    case palau
    case palestinianTerritories
    case panama
    case papuaNewGuinea
    case paraguay
    case peru
    case philippines
    case poland
    case portugal
    case qatar
    case republicOfTheCongo
    case romania
    case russia
    case rwanda
    case saintKittsAndNevis
    case saintLucia
    case saintVincentAndTheGrenadines
    case samoa
    case sanMarino
    case saoTomeAndPrincipe
    case saudiArabia
    case senegal
    case serbia
    case seychelles
    case sierraLeone
    case singapore
    case sintMaarten
    case slovakia
    case slovenia
    case solomonIslands
    case somalia
    case southAfrica
    case southKorea
    case southSudan
    case spain
    case sriLanka
    case sudan
    case suriname
    case swaziland
    case sweden
    case switzerland
    case syria
    case taiwan
    case tajikistan
    case tanzania
    case thailand
    case timorLeste
    case togo
    case tonga
    case trinidadAndTobago
    case tunisia
    case turkey
    case turkmenistan
    case tuvalu
    case uganda
    case ukraine
    case unitedArabEmirates
    case unitedKingdom
    case unitedStatesOfAmerica
    case uruguay
    case uzbekistan
    case vanuatu
    case venezuela
    case vietnam
    case yemen
    case zambia
    case zimbabwe

    static var count: Int {
        return Country.zimbabwe.rawValue
    }

}

// MARK: - LanguageName

enum LanguageName: Int {

    case none
    case afrikaans
    case albanian
    case amharic
    case arabic
    case aramaic
    case armenian
    case assamese
    case aymara
    case azerbaijani
    case balochi
    case bamanankan
    case bashkir
    case basque
    case belarusian
    case bengali
    case bhojpuri
    case bislama
    case bosnian
    case brahui
    case bulgarian
    case burmese
    case cantonese
    case catalan
    case cebuano
    case chechen
    case cherokee
    case croatian
    case czech
    case dakota
    case danish
    case dari
    case dholuo
    case dutch
    case english
    case esperanto
    case estonian
    case ewe
    case finnish
    case french
    case georgian
    case german
    case gikuyu
    case greek
    case guarani
    case gujarati
    case haitianCreole
    case hausa
    case hawaiian
    case hebrew
    case hiligaynon
    case hindi
    case hungarian
    case icelandic
    case igbo
    case ilocano
    case indonesian
    case inuit
    case irishGaelic
    case italian
    case japanese
    case jarai
    case javanese
    case kiche
    case kabyle
    case kannada
    case kashmiri
    case kazakh
    case khmer
    case khoekhoe
    case korean
    case kurdish
    case kyrgyz
    case lao
    case latin
    case latvian
    case lingala
    case lithuanian
    case macedonian
    case maithili
    case malagasy
    case malay
    case malayalam
    case mandarin
    case marathi
    case mende
    case mongolian
    case nahuatl
    case navajo
    case nepali
    case norwegian
    case ojibwa
    case oriya
    case oromo
    case pashto
    case persian
    case polish
    case portuguese
    case punjabi
    case quechua
    case romani
    case romanian
    case russian
    case rwanda
    case samoan
    case sanskrit
    case serbian
    case shona
    case sindhi
    case sinhala
    case slovak
    case slovene
    case somali
    case spanish
    case swahili
    case swedish
    case tachelhit
    case tagalog
    case tajiki
    case tamil
    case tatar
    case telugu
    case thai
    case tigrigna
    case tokPisin
    case turkish
    case turkmen
    case ukrainian
    case urdu
    case uyghur
    case uzbek
    case vietnamese
    case warlpiri
    case welsh
    case wolof
    case xhosa
    case yakut
    case yiddish
    case yoruba
    case yucatec
    case zapotec
    case zulu

    static var count: Int {
        return LanguageName.zulu.rawValue
    }

}

// MARK: - LanguageLevel

enum LanguageLevel: Int {

    case none
    case beginner
    case intermediate
    case advanced
    case fluent
    case native

    static var count: Int {
        return LanguageLevel.native.rawValue
    }

}
