import Foundation

// MARK: - Enums

enum Gender: Int {

    case None
    case Male
    case Female

}

enum Country: Int {

    case None
    case Afghanistan
    case Albania
    case Algeria
    case Andorra
    case Angola
    case AntiguaAndBarbuda
    case Argentina
    case Armenia
    case Aruba
    case Australia
    case Austria
    case Azerbaijan
    case Bahamas
    case Bahrain
    case Bangladesh
    case Barbados
    case Belarus
    case Belgium
    case Belize
    case Benin
    case Bhutan
    case Bolivia
    case BosniaAndHerzegovina
    case Botswana
    case Brazil
    case Brunei
    case Bulgaria
    case BurkinaFaso
    case Burma
    case Burundi
    case Cambodia
    case Cameroon
    case Canada
    case CaboVerde
    case CentralAfricanRepublic
    case Chad
    case Chile
    case China
    case Colombia
    case Comoros
    case CostaRica
    case CotedIvoire
    case Croatia
    case Cuba
    case Curacao
    case Cyprus
    case Czechia
    case DemocraticRepublicOfTheCongo
    case Denmark
    case Djibouti
    case Dominica
    case DominicanRepublic
    case Ecuador
    case Egypt
    case ElSalvador
    case EquatorialGuinea
    case Eritrea
    case Estonia
    case Ethiopia
    case Fiji
    case Finland
    case France
    case Gabon
    case Gambia
    case Georgia
    case Germany
    case Ghana
    case Greece
    case Grenada
    case Guatemala
    case Guinea
    case GuineaBissau
    case Guyana
    case Haiti
    case HolySee
    case Honduras
    case HongKong
    case Hungary
    case Iceland
    case India
    case Indonesia
    case Iran
    case Iraq
    case Ireland
    case Israel
    case Italy
    case Jamaica
    case Japan
    case Jordan
    case Kazakhstan
    case Kenya
    case Kiribati
    case Kosovo
    case Kuwait
    case Kyrgyzstan
    case Laos
    case Latvia
    case Lebanon
    case Lesotho
    case Liberia
    case Libya
    case Liechtenstein
    case Lithuania
    case Luxembourg
    case Macau
    case Macedonia
    case Madagascar
    case Malawi
    case Malaysia
    case Maldives
    case Mali
    case Malta
    case MarshallIslands
    case Mauritania
    case Mauritius
    case Mexico
    case Micronesia
    case Moldova
    case Monaco
    case Mongolia
    case Montenegro
    case Morocco
    case Mozambique
    case Namibia
    case Nauru
    case Nepal
    case Netherlands
    case NewZealand
    case Nicaragua
    case Niger
    case Nigeria
    case NorthKorea
    case Norway
    case Oman
    case Pakistan
    case Palau
    case PalestinianTerritories
    case Panama
    case PapuaNewGuinea
    case Paraguay
    case Peru
    case Philippines
    case Poland
    case Portugal
    case Qatar
    case RepublicOfTheCongo
    case Romania
    case Russia
    case Rwanda
    case SaintKittsAndNevis
    case SaintLucia
    case SaintVincentAndTheGrenadines
    case Samoa
    case SanMarino
    case SaoTomeAndPrincipe
    case SaudiArabia
    case Senegal
    case Serbia
    case Seychelles
    case SierraLeone
    case Singapore
    case SintMaarten
    case Slovakia
    case Slovenia
    case SolomonIslands
    case Somalia
    case SouthAfrica
    case SouthKorea
    case SouthSudan
    case Spain
    case SriLanka
    case Sudan
    case Suriname
    case Swaziland
    case Sweden
    case Switzerland
    case Syria
    case Taiwan
    case Tajikistan
    case Tanzania
    case Thailand
    case TimorLeste
    case Togo
    case Tonga
    case TrinidadAndTobago
    case Tunisia
    case Turkey
    case Turkmenistan
    case Tuvalu
    case Uganda
    case Ukraine
    case UnitedArabEmirates
    case UnitedKingdom
    case UnitedStatesOfAmerica
    case Uruguay
    case Uzbekistan
    case Vanuatu
    case Venezuela
    case Vietnam
    case Yemen
    case Zambia
    case Zimbabwe

    static var count: Int {
        return Country.Zimbabwe.rawValue
    }

}

enum LanguageName: Int {

    case None
    case Afrikaans
    case Albanian
    case Amharic
    case Arabic
    case Aramaic
    case Armenian
    case Assamese
    case Aymara
    case Azerbaijani
    case Balochi
    case Bamanankan
    case Bashkir
    case Basque
    case Belarusian
    case Bengali
    case Bhojpuri
    case Bislama
    case Bosnian
    case Brahui
    case Bulgarian
    case Burmese
    case Cantonese
    case Catalan
    case Cebuano
    case Chechen
    case Cherokee
    case Croatian
    case Czech
    case Dakota
    case Danish
    case Dari
    case Dholuo
    case Dutch
    case English
    case Esperanto
    case Estonian
    case Ewe
    case Finnish
    case French
    case Georgian
    case German
    case Gikuyu
    case Greek
    case Guarani
    case Gujarati
    case HaitianCreole
    case Hausa
    case Hawaiian
    case Hebrew
    case Hiligaynon
    case Hindi
    case Hungarian
    case Icelandic
    case Igbo
    case Ilocano
    case Indonesian
    case Inuit
    case IrishGaelic
    case Italian
    case Japanese
    case Jarai
    case Javanese
    case Kiche
    case Kabyle
    case Kannada
    case Kashmiri
    case Kazakh
    case Khmer
    case Khoekhoe
    case Korean
    case Kurdish
    case Kyrgyz
    case Lao
    case Latin
    case Latvian
    case Lingala
    case Lithuanian
    case Macedonian
    case Maithili
    case Malagasy
    case Malay
    case Malayalam
    case Mandarin
    case Marathi
    case Mende
    case Mongolian
    case Nahuatl
    case Navajo
    case Nepali
    case Norwegian
    case Ojibwa
    case Oriya
    case Oromo
    case Pashto
    case Persian
    case Polish
    case Portuguese
    case Punjabi
    case Quechua
    case Romani
    case Romanian
    case Russian
    case Rwanda
    case Samoan
    case Sanskrit
    case Serbian
    case Shona
    case Sindhi
    case Sinhala
    case Slovak
    case Slovene
    case Somali
    case Spanish
    case Swahili
    case Swedish
    case Tachelhit
    case Tagalog
    case Tajiki
    case Tamil
    case Tatar
    case Telugu
    case Thai
    case Tigrigna
    case TokPisin
    case Turkish
    case Turkmen
    case Ukrainian
    case Urdu
    case Uyghur
    case Uzbek
    case Vietnamese
    case Warlpiri
    case Welsh
    case Wolof
    case Xhosa
    case Yakut
    case Yiddish
    case Yoruba
    case Yucatec
    case Zapotec
    case Zulu

    static var count: Int {
        return LanguageName.Zulu.rawValue
    }

}

enum LanguageLevel: Int {

    case None
    case Beginner
    case Intermediate
    case Advanced
    case Fluent
    case Native

    static var count: Int {
        return LanguageLevel.Native.rawValue
    }

}
