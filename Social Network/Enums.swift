import Foundation

// MARK: - Enums

enum Gender: Int {

    case None
    case Male
    case Female

    var stringValue: String {
        switch self {
        case .None:
            return "None"

        case .Male:
            return "Male"

        case .Female:
            return "Female"
        }
    }

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

    var stringValue: String {
        switch self {
        case .None:
            return "None"

        case .Afghanistan:
            return "Afghanistan"

        case .Albania:
            return "Albania"

        case .Algeria:
            return "Algeria"

        case .Andorra:
            return "Andorra"

        case .Angola:
            return "Angola"

        case .AntiguaAndBarbuda:
            return "Antigua and Barbuda"

        case .Argentina:
            return "Argentina"

        case .Armenia:
            return "Armenia"

        case .Aruba:
            return "Aruba"

        case .Australia:
            return "Australia"

        case .Austria:
            return "Austria"

        case .Azerbaijan:
            return "Azerbaijan"

        case .Bahamas:
            return "The Bahamas"

        case .Bahrain:
            return "Bahrain"

        case .Bangladesh:
            return "Bangladesh"

        case .Barbados:
            return "Barbados"

        case .Belarus:
            return "Belarus"

        case .Belgium:
            return "Belgium"

        case .Belize:
            return "Belize"

        case .Benin:
            return "Benin"

        case .Bhutan:
            return "Bhutan"

        case .Bolivia:
            return "Bolivia"

        case .BosniaAndHerzegovina:
            return "Bosnia and Herzegovina"

        case .Botswana:
            return "Botswana"

        case .Brazil:
            return "Brazil"

        case .Brunei:
            return "Brunei"

        case .Bulgaria:
            return "Bulgaria"

        case .BurkinaFaso:
            return "Burkina Faso"

        case .Burma:
            return "Burma"

        case .Burundi:
            return "Burundi"

        case .Cambodia:
            return "Cambodia"

        case .Cameroon:
            return "Cameroon"

        case .Canada:
            return "Canada"

        case .CaboVerde:
            return "Cabo Verde"

        case .CentralAfricanRepublic:
            return "Central African Republic"

        case .Chad:
            return "Chad"

        case .Chile:
            return "Chile"

        case .China:
            return "China"

        case .Colombia:
            return "Colombia"

        case .Comoros:
            return "Comoros"

        case .CostaRica:
            return "Costa Rica"

        case .CotedIvoire:
            return "Cote d'Ivoire"

        case .Croatia:
            return "Croatia"

        case .Cuba:
            return "Cuba"

        case .Curacao:
            return "Curacao"

        case .Cyprus:
            return "Cyprus"

        case .Czechia:
            return "Czechia"

        case .DemocraticRepublicOfTheCongo:
            return "Democratic Republic of The Congo"

        case .Denmark:
            return "Denmark"

        case .Djibouti:
            return "Djibouti"

        case .Dominica:
            return "Dominica"

        case .DominicanRepublic:
            return "Dominican Republic"

        case .Ecuador:
            return "Ecuador"

        case .Egypt:
            return "Egypt"

        case .ElSalvador:
            return "El Salvador"

        case .EquatorialGuinea:
            return "Equatorial Guinea"

        case .Eritrea:
            return "Eritrea"

        case .Estonia:
            return "Estonia"

        case .Ethiopia:
            return "Ethiopia"

        case .Fiji:
            return "Fiji"

        case .Finland:
            return "Finland"

        case .France:
            return "France"

        case .Gabon:
            return "Gabon"

        case .Gambia:
            return "Gambia"

        case .Georgia:
            return "Georgia"

        case .Germany:
            return "Germany"

        case .Ghana:
            return "Ghana"

        case .Greece:
            return "Greece"

        case .Grenada:
            return "Grenada"

        case .Guatemala:
            return "Guatemala"

        case .Guinea:
            return "Guinea"

        case .GuineaBissau:
            return "Guinea Bissau"

        case .Guyana:
            return "Guyana"

        case .Haiti:
            return "Haiti"

        case .HolySee:
            return "Holy See"

        case .Honduras:
            return "Honduras"

        case .HongKong:
            return "Hong Kong"

        case .Hungary:
            return "Hungary"

        case .Iceland:
            return "Iceland"

        case .India:
            return "India"

        case .Indonesia:
            return "Indonesia"

        case .Iran:
            return "Iran"

        case .Iraq:
            return "Iraq"

        case .Ireland:
            return "Ireland"

        case .Israel:
            return "Israel"

        case .Italy:
            return "Italy"

        case .Jamaica:
            return "Jamaica"

        case .Japan:
            return "Japan"

        case .Jordan:
            return "Jordan"

        case .Kazakhstan:
            return "Kazakhstan"

        case .Kenya:
            return "Kenya"

        case .Kiribati:
            return "Kiribati"

        case .Kosovo:
            return "Kosovo"

        case .Kuwait:
            return "Kuwait"

        case .Kyrgyzstan:
            return "Kyrgyzstan"

        case .Laos:
            return "Laos"

        case .Latvia:
            return "Latvia"

        case .Lebanon:
            return "Lebanon"

        case .Lesotho:
            return "Lesotho"

        case .Liberia:
            return "Liberia"

        case .Libya:
            return "Libya"

        case .Liechtenstein:
            return "Liechtenstein"

        case .Lithuania:
            return "Lithuania"

        case .Luxembourg:
            return "Luxembourg"

        case .Macau:
            return "Macau"

        case .Macedonia:
            return "Macedonia"

        case .Madagascar:
            return "Madagascar"

        case .Malawi:
            return "Malawi"

        case .Malaysia:
            return "Malaysia"

        case .Maldives:
            return "Maldives"

        case .Mali:
            return "Mali"

        case .Malta:
            return "Malta"

        case .MarshallIslands:
            return "Marshall Islands"

        case .Mauritania:
            return "Mauritania"

        case .Mauritius:
            return "Mauritius"

        case .Mexico:
            return "Mexico"

        case .Micronesia:
            return "Micronesia"

        case .Moldova:
            return "Moldova"

        case .Monaco:
            return "Monaco"

        case .Mongolia:
            return "Mongolia"

        case .Montenegro:
            return "Montenegro"

        case .Morocco:
            return "Morocco"

        case .Mozambique:
            return "Mozambique"

        case .Namibia:
            return "Namibia"

        case .Nauru:
            return "Nauru"

        case .Nepal:
            return "Nepal"

        case .Netherlands:
            return "Netherlands"

        case .NewZealand:
            return "New Zealand"

        case .Nicaragua:
            return "Nicaragua"

        case .Niger:
            return "Niger"

        case .Nigeria:
            return "Nigeria"

        case .NorthKorea:
            return "North Korea"

        case .Norway:
            return "Norway"

        case .Oman:
            return "Oman"

        case .Pakistan:
            return "Pakistan"

        case .Palau:
            return "Palau"

        case .PalestinianTerritories:
            return "Palestinian Territories"

        case .Panama:
            return "Panama"

        case .PapuaNewGuinea:
            return "Papua New Guinea"

        case .Paraguay:
            return "Paraguay"

        case .Peru:
            return "Peru"

        case .Philippines:
            return "Philippines"

        case .Poland:
            return "Poland"

        case .Portugal:
            return "Portugal"

        case .Qatar:
            return "Qatar"

        case .RepublicOfTheCongo:
            return "Republic of The Congo"

        case .Romania:
            return "Romania"

        case .Russia:
            return "Russia"

        case .Rwanda:
            return "Rwanda"

        case .SaintKittsAndNevis:
            return "Saint Kitts and Nevis"

        case .SaintLucia:
            return "Saint Lucia"

        case .SaintVincentAndTheGrenadines:
            return "Saint Vincent and The Grenadines"

        case .Samoa:
            return "Samoa"

        case .SanMarino:
            return "San Marino"

        case .SaoTomeAndPrincipe:
            return "Sao Tome and Principe"

        case .SaudiArabia:
            return "Saudi Arabia"

        case .Senegal:
            return "Senegal"

        case .Serbia:
            return "Serbia"

        case .Seychelles:
            return "Seychelles"

        case .SierraLeone:
            return "Sierra Leone"

        case .Singapore:
            return "Singapore"

        case .SintMaarten:
            return "Sint Maarten"

        case .Slovakia:
            return "Slovakia"

        case .Slovenia:
            return "Slovenia"

        case .SolomonIslands:
            return "Solomon Islands"

        case .Somalia:
            return "Somalia"

        case .SouthAfrica:
            return "South Africa"

        case .SouthKorea:
            return "South Korea"

        case .SouthSudan:
            return "South Sudan"

        case .Spain:
            return "Spain"

        case .SriLanka:
            return "Sri Lanka"

        case .Sudan:
            return "Sudan"

        case .Suriname:
            return "Suriname"

        case .Swaziland:
            return "Swaziland"

        case .Sweden:
            return "Sweden"

        case .Switzerland:
            return "Switzerland"

        case .Syria:
            return "Syria"

        case .Taiwan:
            return "Taiwan"

        case .Tajikistan:
            return "Tajikistan"

        case .Tanzania:
            return "Tanzania"

        case .Thailand:
            return "Thailand"

        case .TimorLeste:
            return "Timor-Leste"

        case .Togo:
            return "Togo"

        case .Tonga:
            return "Tonga"

        case .TrinidadAndTobago:
            return "Trinidad and Tobago"

        case .Tunisia:
            return "Tunisia"

        case .Turkey:
            return "Turkey"

        case .Turkmenistan:
            return "Turkmenistan"

        case .Tuvalu:
            return "Tuvalu"

        case .Uganda:
            return "Uganda"

        case .Ukraine:
            return "Ukraine"

        case .UnitedArabEmirates:
            return "United Arab Emirates"

        case .UnitedKingdom:
            return "United Kingdom"

        case .UnitedStatesOfAmerica:
            return "United States of America"

        case .Uruguay:
            return "Uruguay"

        case .Uzbekistan:
            return "Uzbekistan"

        case .Vanuatu:
            return "Vanuatu"

        case .Venezuela:
            return "Venezuela"

        case .Vietnam:
            return "Vietnam"

        case .Yemen:
            return "Yemen"

        case .Zambia:
            return "Zambia"

        case .Zimbabwe:
            return "Zimbabwe"
        }
    }

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

    var stringValue: String {
        switch self {
        case .None:
            return "None"

        case .Afrikaans:
            return "Afrikaans"

        case .Albanian:
            return "Albanian"

        case .Amharic:
            return "Amharic"

        case .Arabic:
            return "Arabic"

        case .Aramaic:
            return "Aramaic"

        case .Armenian:
            return "Armenian"

        case .Assamese:
            return "Assamese"

        case .Aymara:
            return "Aymara"

        case .Azerbaijani:
            return "Azerbaijani"

        case .Balochi:
            return "Balochi"

        case .Bamanankan:
            return "Bamanankan"

        case .Bashkir:
            return "Bashkir"

        case .Basque:
            return "Basque"

        case .Belarusian:
            return "Belarusian"

        case .Bengali:
            return "Bengali"

        case .Bhojpuri:
            return "Bhojpuri"

        case .Bislama:
            return "Bislama"

        case .Bosnian:
            return "Bosnian"

        case .Brahui:
            return "Brahui"

        case .Bulgarian:
            return "Bulgarian"

        case .Burmese:
            return "Burmese"

        case .Cantonese:
            return "Cantonese"

        case .Catalan:
            return "Catalan"

        case .Cebuano:
            return "Cebuano"

        case .Chechen:
            return "Chechen"

        case .Cherokee:
            return "Cherokee"

        case .Croatian:
            return "Croatian"

        case .Czech:
            return "Czech"

        case .Dakota:
            return "Dakota"

        case .Danish:
            return "Danish"

        case .Dari:
            return "Dari"

        case .Dholuo:
            return "Dholuo"

        case .Dutch:
            return "Dutch"

        case .English:
            return "English"

        case .Esperanto:
            return "Esperanto"

        case .Estonian:
            return "Estonian"

        case .Ewe:
            return "Éwé"

        case .Finnish:
            return "Finnish"

        case .French:
            return "French"

        case .Georgian:
            return "Georgian"

        case .German:
            return "German"

        case .Gikuyu:
            return "Gikuyu"

        case .Greek:
            return "Greek"

        case .Guarani:
            return "Guarani"

        case .Gujarati:
            return "Gujarati"

        case .HaitianCreole:
            return "Haitian Creole"

        case .Hausa:
            return "Hausa"

        case .Hawaiian:
            return "Hawaiian"

        case .Hebrew:
            return "Hebrew"

        case .Hiligaynon:
            return "Hiligaynon"

        case .Hindi:
            return "Hindi"

        case .Hungarian:
            return "Hungarian"

        case .Icelandic:
            return "Icelandic"

        case .Igbo:
            return "Igbo"

        case .Ilocano:
            return "Ilocano"

        case .Indonesian:
            return "Indonesian"

        case .Inuit:
            return "Inuit"

        case .IrishGaelic:
            return "Irish Gaelic"

        case .Italian:
            return "Italian"

        case .Japanese:
            return "Japanese"

        case .Jarai:
            return "Jarai"

        case .Javanese:
            return "Javanese"

        case .Kiche:
            return "Kiche"

        case .Kabyle:
            return "Kabyle"

        case .Kannada:
            return "Kannada"

        case .Kashmiri:
            return "Kashmiri"

        case .Kazakh:
            return "Kazakh"

        case .Khmer:
            return "Khmer"

        case .Khoekhoe:
            return "Khoekhoe"

        case .Korean:
            return "Korean"

        case .Kurdish:
            return "Kurdish"

        case .Kyrgyz:
            return "Kyrgyz"

        case .Lao:
            return "Lao"

        case .Latin:
            return "Latin"

        case .Latvian:
            return "Latvian"

        case .Lingala:
            return "Lingala"

        case .Lithuanian:
            return "Lithuanian"

        case .Macedonian:
            return "Macedonian"

        case .Maithili:
            return "Maithili"

        case .Malagasy:
            return "Malagasy"

        case .Malay:
            return "Malay"

        case .Malayalam:
            return "Malayalam"

        case .Mandarin:
            return "Mandarin"

        case .Marathi:
            return "Marathi"

        case .Mende:
            return "Mende"

        case .Mongolian:
            return "Mongolian"

        case .Nahuatl:
            return "Nahuatl"

        case .Navajo:
            return "Navajo"

        case .Nepali:
            return "Nepali"

        case .Norwegian:
            return "Norwegian"

        case .Ojibwa:
            return "Ojibwa"

        case .Oriya:
            return "Oriya"

        case .Oromo:
            return "Oromo"

        case .Pashto:
            return "Pashto"

        case .Persian:
            return "Persian"

        case .Polish:
            return "Polish"

        case .Portuguese:
            return "Portuguese"

        case .Punjabi:
            return "Punjabi"

        case .Quechua:
            return "Quechua"

        case .Romani:
            return "Romani"

        case .Romanian:
            return "Romanian"

        case .Russian:
            return "Russian"

        case .Rwanda:
            return "Rwanda"

        case .Samoan:
            return "Samoan"

        case .Sanskrit:
            return "Sanskrit"

        case .Serbian:
            return "Serbian"

        case .Shona:
            return "Shona"

        case .Sindhi:
            return "Sindhi"

        case .Sinhala:
            return "Sinhala"

        case .Slovak:
            return "Slovak"

        case .Slovene:
            return "Slovene"

        case .Somali:
            return "Somali"

        case .Spanish:
            return "Spanish"

        case .Swahili:
            return "Swahili"

        case .Swedish:
            return "Swedish"

        case .Tachelhit:
            return "Tachelhit"

        case .Tagalog:
            return "Tagalog"

        case .Tajiki:
            return "Tajiki"

        case .Tamil:
            return "Tamil"

        case .Tatar:
            return "Tatar"

        case .Telugu:
            return "Telugu"

        case .Thai:
            return "Thai"

        case .Tigrigna:
            return "Tigrigna"

        case .TokPisin:
            return "Tok Pisin"

        case .Turkish:
            return "Turkish"

        case .Turkmen:
            return "Turkmen"

        case .Ukrainian:
            return "Ukrainian"

        case .Urdu:
            return "Urdu"

        case .Uyghur:
            return "Uyghur"

        case .Uzbek:
            return "Uzbek"

        case .Vietnamese:
            return "Vietnamese"

        case .Warlpiri:
            return "Warlpiri"

        case .Welsh:
            return "Welsh"

        case .Wolof:
            return "Wolof"

        case .Xhosa:
            return "Xhosa"

        case .Yakut:
            return "Yakut"

        case .Yiddish:
            return "Yiddish"

        case .Yoruba:
            return "Yoruba"

        case .Yucatec:
            return "Yucatec"

        case .Zapotec:
            return "Zapotec"

        case .Zulu:
            return "Zulu"
        }
    }

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

    var stringValue: String {
        switch self {
        case .None:
            return "None"

        case .Beginner:
            return "Beginner"

        case .Intermediate:
            return "Intermediate"

        case .Advanced:
            return "Advanced"

        case .Fluent:
            return "Fluent"

        case .Native:
            return "Native"
        }
    }

    static var count: Int {
        return LanguageLevel.Native.rawValue
    }

}
