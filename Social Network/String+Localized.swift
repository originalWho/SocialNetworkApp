import Foundation

extension String {

    struct Localized {

        struct Gender {
            static var None: String { return "None" }
            static var Male: String { return "Male" }
            static var Female: String { return "Female" }
        }

        struct Country {
            static var None: String { return "None" }
            static var Afghanistan: String { return "Afghanistan" }
            static var Albania: String { return "Albania" }
            static var Algeria: String { return "Algeria" }
            static var Andorra: String { return "Andorra" }
            static var Angola: String { return "Angola" }
            static var AntiguaAndBarbuda: String { return "Antigua and Barbuda" }
            static var Argentina: String { return "Argentina" }
            static var Armenia: String { return "Armenia" }
            static var Aruba: String { return "Aruba" }
            static var Australia: String { return "Australia" }
            static var Austria: String { return "Austria" }
            static var Azerbaijan: String { return "Azerbaijan" }
            static var Bahamas: String { return "The Bahamas" }
            static var Bahrain: String { return "Bahrain" }
            static var Bangladesh: String { return "Bangladesh" }
            static var Barbados: String { return "Barbados" }
            static var Belarus: String { return "Belarus" }
            static var Belgium: String { return "Belgium" }
            static var Belize: String { return "Belize" }
            static var Benin: String { return "Benin" }
            static var Bhutan: String { return "Bhutan" }
            static var Bolivia: String { return "Bolivia" }
            static var BosniaAndHerzegovina: String { return "Bosnia and Herzegovina" }
            static var Botswana: String { return "Botswana" }
            static var Brazil: String { return "Brazil" }
            static var Brunei: String { return "Brunei" }
            static var Bulgaria: String { return "Bulgaria" }
            static var BurkinaFaso: String { return "Burkina Faso" }
            static var Burma: String { return "Burma" }
            static var Burundi: String { return "Burundi" }
            static var Cambodia: String { return "Cambodia" }
            static var Cameroon: String { return "Cameroon" }
            static var Canada: String { return "Canada" }
            static var CaboVerde: String { return "Cabo Verde" }
            static var CentralAfricanRepublic: String { return "Central African Republic" }
            static var Chad: String { return "Chad" }
            static var Chile: String { return "Chile" }
            static var China: String { return "China" }
            static var Colombia: String { return "Colombia" }
            static var Comoros: String { return "Comoros" }
            static var CostaRica: String { return "Costa Rica" }
            static var CotedIvoire: String { return "Cote d'Ivoire" }
            static var Croatia: String { return "Croatia" }
            static var Cuba: String { return "Cuba" }
            static var Curacao: String { return "Curacao" }
            static var Cyprus: String { return "Cyprus" }
            static var Czechia: String { return "Czechia" }
            static var DemocraticRepublicOfTheCongo: String { return "Democratic Republic of The Congo" }
            static var Denmark: String { return "Denmark" }
            static var Djibouti: String { return "Djibouti" }
            static var Dominica: String { return "Dominica" }
            static var DominicanRepublic: String { return "Dominican Republic" }
            static var Ecuador: String { return "Ecuador" }
            static var Egypt: String { return "Egypt" }
            static var ElSalvador: String { return "El Salvador" }
            static var EquatorialGuinea: String { return "Equatorial Guinea" }
            static var Eritrea: String { return "Eritrea" }
            static var Estonia: String { return "Estonia" }
            static var Ethiopia: String { return "Ethiopia" }
            static var Fiji: String { return "Fiji" }
            static var Finland: String { return "Finland" }
            static var France: String { return "France" }
            static var Gabon: String { return "Gabon" }
            static var Gambia: String { return "Gambia" }
            static var Georgia: String { return "Georgia" }
            static var Germany: String { return "Germany" }
            static var Ghana: String { return "Ghana" }
            static var Greece: String { return "Greece" }
            static var Grenada: String { return "Grenada" }
            static var Guatemala: String { return "Guatemala" }
            static var Guinea: String { return "Guinea" }
            static var GuineaBissau: String { return "Guinea Bissau" }
            static var Guyana: String { return "Guyana" }
            static var Haiti: String { return "Haiti" }
            static var HolySee: String { return "Holy See" }
            static var Honduras: String { return "Honduras" }
            static var HongKong: String { return "Hong Kong" }
            static var Hungary: String { return "Hungary" }
            static var Iceland: String { return "Iceland" }
            static var India: String { return "India" }
            static var Indonesia: String { return "Indonesia" }
            static var Iran: String { return "Iran" }
            static var Iraq: String { return "Iraq" }
            static var Ireland: String { return "Ireland" }
            static var Israel: String { return "Israel" }
            static var Italy: String { return "Italy" }
            static var Jamaica: String { return "Jamaica" }
            static var Japan: String { return "Japan" }
            static var Jordan: String { return "Jordan" }
            static var Kazakhstan: String { return "Kazakhstan" }
            static var Kenya: String { return "Kenya" }
            static var Kiribati: String { return "Kiribati" }
            static var Kosovo: String { return "Kosovo" }
            static var Kuwait: String { return "Kuwait" }
            static var Kyrgyzstan: String { return "Kyrgyzstan" }
            static var Laos: String { return "Laos" }
            static var Latvia: String { return "Latvia" }
            static var Lebanon: String { return "Lebanon" }
            static var Lesotho: String { return "Lesotho" }
            static var Liberia: String { return "Liberia" }
            static var Libya: String { return "Libya" }
            static var Liechtenstein: String { return "Liechtenstein" }
            static var Lithuania: String { return "Lithuania" }
            static var Luxembourg: String { return "Luxembourg" }
            static var Macau: String { return "Macau" }
            static var Macedonia: String { return "Macedonia" }
            static var Madagascar: String { return "Madagascar" }
            static var Malawi: String { return "Malawi" }
            static var Malaysia: String { return "Malaysia" }
            static var Maldives: String { return "Maldives" }
            static var Mali: String { return "Mali" }
            static var Malta: String { return "Malta" }
            static var MarshallIslands: String { return "Marshall Islands" }
            static var Mauritania: String { return "Mauritania" }
            static var Mauritius: String { return "Mauritius" }
            static var Mexico: String { return "Mexico" }
            static var Micronesia: String { return "Micronesia" }
            static var Moldova: String { return "Moldova" }
            static var Monaco: String { return "Monaco" }
            static var Mongolia: String { return "Mongolia" }
            static var Montenegro: String { return "Montenegro" }
            static var Morocco: String { return "Morocco" }
            static var Mozambique: String { return "Mozambique" }
            static var Namibia: String { return "Namibia" }
            static var Nauru: String { return "Nauru" }
            static var Nepal: String { return "Nepal" }
            static var Netherlands: String { return "Netherlands" }
            static var NewZealand: String { return "New Zealand" }
            static var Nicaragua: String { return "Nicaragua" }
            static var Niger: String { return "Niger" }
            static var Nigeria: String { return "Nigeria" }
            static var NorthKorea: String { return "North Korea" }
            static var Norway: String { return "Norway" }
            static var Oman: String { return "Oman" }
            static var Pakistan: String { return "Pakistan" }
            static var Palau: String { return "Palau" }
            static var PalestinianTerritories: String { return "Palestinian Territories" }
            static var Panama: String { return "Panama" }
            static var PapuaNewGuinea: String { return "Papua New Guinea" }
            static var Paraguay: String { return "Paraguay" }
            static var Peru: String { return "Peru" }
            static var Philippines: String { return "Philippines" }
            static var Poland: String { return "Poland" }
            static var Portugal: String { return "Portugal" }
            static var Qatar: String { return "Qatar" }
            static var RepublicOfTheCongo: String { return "Republic of The Congo" }
            static var Romania: String { return "Romania" }
            static var Russia: String { return "Russia" }
            static var Rwanda: String { return "Rwanda" }
            static var SaintKittsAndNevis: String { return "Saint Kitts and Nevis" }
            static var SaintLucia: String { return "Saint Lucia" }
            static var SaintVincentAndTheGrenadines: String { return "Saint Vincent and The Grenadines" }
            static var Samoa: String { return "Samoa" }
            static var SanMarino: String { return "San Marino" }
            static var SaoTomeAndPrincipe: String { return "Sao Tome and Principe" }
            static var SaudiArabia: String { return "Saudi Arabia" }
            static var Senegal: String { return "Senegal" }
            static var Serbia: String { return "Serbia" }
            static var Seychelles: String { return "Seychelles" }
            static var SierraLeone: String { return "Sierra Leone" }
            static var Singapore: String { return "Singapore" }
            static var SintMaarten: String { return "Sint Maarten" }
            static var Slovakia: String { return "Slovakia" }
            static var Slovenia: String { return "Slovenia" }
            static var SolomonIslands: String { return "Solomon Islands" }
            static var Somalia: String { return "Somalia" }
            static var SouthAfrica: String { return "South Africa" }
            static var SouthKorea: String { return "South Korea" }
            static var SouthSudan: String { return "South Sudan" }
            static var Spain: String { return "Spain" }
            static var SriLanka: String { return "Sri Lanka" }
            static var Sudan: String { return "Sudan" }
            static var Suriname: String { return "Suriname" }
            static var Swaziland: String { return "Swaziland" }
            static var Sweden: String { return "Sweden" }
            static var Switzerland: String { return "Switzerland" }
            static var Syria: String { return "Syria" }
            static var Taiwan: String { return "Taiwan" }
            static var Tajikistan: String { return "Tajikistan" }
            static var Tanzania: String { return "Tanzania" }
            static var Thailand: String { return "Thailand" }
            static var TimorLeste: String { return "Timor-Leste" }
            static var Togo: String { return "Togo" }
            static var Tonga: String { return "Tonga" }
            static var TrinidadAndTobago: String { return "Trinidad and Tobago" }
            static var Tunisia: String { return "Tunisia" }
            static var Turkey: String { return "Turkey" }
            static var Turkmenistan: String { return "Turkmenistan" }
            static var Tuvalu: String { return "Tuvalu" }
            static var Uganda: String { return "Uganda" }
            static var Ukraine: String { return "Ukraine" }
            static var UnitedArabEmirates: String { return "United Arab Emirates" }
            static var UnitedKingdom: String { return "United Kingdom" }
            static var UnitedStatesOfAmerica: String { return "United States of America" }
            static var Uruguay: String { return "Uruguay" }
            static var Uzbekistan: String { return "Uzbekistan" }
            static var Vanuatu: String { return "Vanuatu" }
            static var Venezuela: String { return "Venezuela" }
            static var Vietnam: String { return "Vietnam" }
            static var Yemen: String { return "Yemen" }
            static var Zambia: String { return "Zambia" }
            static var Zimbabwe: String { return "Zimbabwe" }
        }

        struct LanguageName {
            static var None: String { return "None" }
            static var Afrikaans: String { return "Afrikaans" }
            static var Albanian: String { return "Albanian" }
            static var Amharic: String { return "Amharic" }
            static var Arabic: String { return "Arabic" }
            static var Aramaic: String { return "Aramaic" }
            static var Armenian: String { return "Armenian" }
            static var Assamese: String { return "Assamese" }
            static var Aymara: String { return "Aymara" }
            static var Azerbaijani: String { return "Azerbaijani" }
            static var Balochi: String { return "Balochi" }
            static var Bamanankan: String { return "Bamanankan" }
            static var Bashkir: String { return "Bashkir" }
            static var Basque: String { return "Basque" }
            static var Belarusian: String { return "Belarusian" }
            static var Bengali: String { return "Bengali" }
            static var Bhojpuri: String { return "Bhojpuri" }
            static var Bislama: String { return "Bislama" }
            static var Bosnian: String { return "Bosnian" }
            static var Brahui: String { return "Brahui" }
            static var Bulgarian: String { return "Bulgarian" }
            static var Burmese: String { return "Burmese" }
            static var Cantonese: String { return "Cantonese" }
            static var Catalan: String { return "Catalan" }
            static var Cebuano: String { return "Cebuano" }
            static var Chechen: String { return "Chechen" }
            static var Cherokee: String { return "Cherokee" }
            static var Croatian: String { return "Croatian" }
            static var Czech: String { return "Czech" }
            static var Dakota: String { return "Dakota" }
            static var Danish: String { return "Danish" }
            static var Dari: String { return "Dari" }
            static var Dholuo: String { return "Dholuo" }
            static var Dutch: String { return "Dutch" }
            static var English: String { return "English" }
            static var Esperanto: String { return "Esperanto" }
            static var Estonian: String { return "Estonian" }
            static var Ewe: String { return "Éwé" }
            static var Finnish: String { return "Finnish" }
            static var French: String { return "French" }
            static var Georgian: String { return "Georgian" }
            static var German: String { return "German" }
            static var Gikuyu: String { return "Gikuyu" }
            static var Greek: String { return "Greek" }
            static var Guarani: String { return "Guarani" }
            static var Gujarati: String { return "Gujarati" }
            static var HaitianCreole: String { return "Haitian Creole" }
            static var Hausa: String { return "Hausa" }
            static var Hawaiian: String { return "Hawaiian" }
            static var Hebrew: String { return "Hebrew" }
            static var Hiligaynon: String { return "Hiligaynon" }
            static var Hindi: String { return "Hindi" }
            static var Hungarian: String { return "Hungarian" }
            static var Icelandic: String { return "Icelandic" }
            static var Igbo: String { return "Igbo" }
            static var Ilocano: String { return "Ilocano" }
            static var Indonesian: String { return "Indonesian" }
            static var Inuit: String { return "Inuit" }
            static var IrishGaelic: String { return "Irish Gaelic" }
            static var Italian: String { return "Italian" }
            static var Japanese: String { return "Japanese" }
            static var Jarai: String { return "Jarai" }
            static var Javanese: String { return "Javanese" }
            static var Kiche: String { return "Kiche" }
            static var Kabyle: String { return "Kabyle" }
            static var Kannada: String { return "Kannada" }
            static var Kashmiri: String { return "Kashmiri" }
            static var Kazakh: String { return "Kazakh" }
            static var Khmer: String { return "Khmer" }
            static var Khoekhoe: String { return "Khoekhoe" }
            static var Korean: String { return "Korean" }
            static var Kurdish: String { return "Kurdish" }
            static var Kyrgyz: String { return "Kyrgyz" }
            static var Lao: String { return "Lao" }
            static var Latin: String { return "Latin" }
            static var Latvian: String { return "Latvian" }
            static var Lingala: String { return "Lingala" }
            static var Lithuanian: String { return "Lithuanian" }
            static var Macedonian: String { return "Macedonian" }
            static var Maithili: String { return "Maithili" }
            static var Malagasy: String { return "Malagasy" }
            static var Malay: String { return "Malay" }
            static var Malayalam: String { return "Malayalam" }
            static var Mandarin: String { return "Mandarin" }
            static var Marathi: String { return "Marathi" }
            static var Mende: String { return "Mende" }
            static var Mongolian: String { return "Mongolian" }
            static var Nahuatl: String { return "Nahuatl" }
            static var Navajo: String { return "Navajo" }
            static var Nepali: String { return "Nepali" }
            static var Norwegian: String { return "Norwegian" }
            static var Ojibwa: String { return "Ojibwa" }
            static var Oriya: String { return "Oriya" }
            static var Oromo: String { return "Oromo" }
            static var Pashto: String { return "Pashto" }
            static var Persian: String { return "Persian" }
            static var Polish: String { return "Polish" }
            static var Portuguese: String { return "Portuguese" }
            static var Punjabi: String { return "Punjabi" }
            static var Quechua: String { return "Quechua" }
            static var Romani: String { return "Romani" }
            static var Romanian: String { return "Romanian" }
            static var Russian: String { return "Russian" }
            static var Rwanda: String { return "Rwanda" }
            static var Samoan: String { return "Samoan" }
            static var Sanskrit: String { return "Sanskrit" }
            static var Serbian: String { return "Serbian" }
            static var Shona: String { return "Shona" }
            static var Sindhi: String { return "Sindhi" }
            static var Sinhala: String { return "Sinhala" }
            static var Slovak: String { return "Slovak" }
            static var Slovene: String { return "Slovene" }
            static var Somali: String { return "Somali" }
            static var Spanish: String { return "Spanish" }
            static var Swahili: String { return "Swahili" }
            static var Swedish: String { return "Swedish" }
            static var Tachelhit: String { return "Tachelhit" }
            static var Tagalog: String { return "Tagalog" }
            static var Tajiki: String { return "Tajiki" }
            static var Tamil: String { return "Tamil" }
            static var Tatar: String { return "Tatar" }
            static var Telugu: String { return "Telugu" }
            static var Thai: String { return "Thai" }
            static var Tigrigna: String { return "Tigrigna" }
            static var TokPisin: String { return "Tok Pisin" }
            static var Turkish: String { return "Turkish" }
            static var Turkmen: String { return "Turkmen" }
            static var Ukrainian: String { return "Ukrainian" }
            static var Urdu: String { return "Urdu" }
            static var Uyghur: String { return "Uyghur" }
            static var Uzbek: String { return "Uzbek" }
            static var Vietnamese: String { return "Vietnamese" }
            static var Warlpiri: String { return "Warlpiri" }
            static var Welsh: String { return "Welsh" }
            static var Wolof: String { return "Wolof" }
            static var Xhosa: String { return "Xhosa" }
            static var Yakut: String { return "Yakut" }
            static var Yiddish: String { return "Yiddish" }
            static var Yoruba: String { return "Yoruba" }
            static var Yucatec: String { return "Yucatec" }
            static var Zapotec: String { return "Zapotec" }
            static var Zulu: String { return "Zulu" }
        }
        
        struct LanguageLevel {
            static var None: String { return "None" }
            static var Beginner: String { return "Beginner" }
            static var Intermediate: String { return "Intermediate" }
            static var Advanced: String { return "Advanced" }
            static var Fluent: String { return "Fluent" }
            static var Native: String { return "Native" }
        }
        
    }
    
}
