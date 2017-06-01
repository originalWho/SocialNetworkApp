import Foundation

// MARK: - Gender

extension Gender {

    private typealias Localized = String.Localized.Gender

    var localized: String {
        switch self {
        case .none:
            return Localized.None

        case .male:
            return Localized.Male

        case .female:
            return Localized.Female
        }
    }

}

// MARK: - Country

extension Country {

    private typealias Localized = String.Localized.Country

    var localized: String {
        switch self {
        case .none:
            return Localized.None

        case .afghanistan:
            return Localized.Afghanistan

        case .albania:
            return Localized.Albania

        case .algeria:
            return Localized.Algeria

        case .andorra:
            return Localized.Andorra

        case .angola:
            return Localized.Angola

        case .antiguaAndBarbuda:
            return Localized.AntiguaAndBarbuda

        case .argentina:
            return Localized.Argentina

        case .armenia:
            return Localized.Armenia

        case .aruba:
            return Localized.Aruba

        case .australia:
            return Localized.Australia

        case .austria:
            return Localized.Austria

        case .azerbaijan:
            return Localized.Azerbaijan

        case .bahamas:
            return Localized.Bahamas

        case .bahrain:
            return Localized.Bahrain

        case .bangladesh:
            return Localized.Bangladesh

        case .barbados:
            return Localized.Barbados

        case .belarus:
            return Localized.Belarus

        case .belgium:
            return Localized.Belgium

        case .belize:
            return Localized.Belize

        case .benin:
            return Localized.Benin

        case .bhutan:
            return Localized.Bhutan

        case .bolivia:
            return Localized.Bolivia

        case .bosniaAndHerzegovina:
            return Localized.BosniaAndHerzegovina

        case .botswana:
            return Localized.Botswana

        case .brazil:
            return Localized.Brazil

        case .brunei:
            return Localized.Brunei

        case .bulgaria:
            return Localized.Bulgaria

        case .burkinaFaso:
            return Localized.BurkinaFaso

        case .burma:
            return Localized.Burma

        case .burundi:
            return Localized.Burundi

        case .cambodia:
            return Localized.Cambodia

        case .cameroon:
            return Localized.Cameroon

        case .canada:
            return Localized.Canada

        case .caboVerde:
            return Localized.CaboVerde

        case .centralAfricanRepublic:
            return Localized.CentralAfricanRepublic

        case .chad:
            return Localized.Chad

        case .chile:
            return Localized.Chile

        case .china:
            return Localized.China

        case .colombia:
            return Localized.Colombia

        case .comoros:
            return Localized.Comoros

        case .costaRica:
            return Localized.CostaRica

        case .cotedIvoire:
            return Localized.CotedIvoire

        case .croatia:
            return Localized.Croatia

        case .cuba:
            return Localized.Cuba

        case .curacao:
            return Localized.Curacao

        case .cyprus:
            return Localized.Cyprus

        case .czechia:
            return Localized.Czechia

        case .democraticRepublicOfTheCongo:
            return Localized.DemocraticRepublicOfTheCongo

        case .denmark:
            return Localized.Denmark

        case .djibouti:
            return Localized.Djibouti

        case .dominica:
            return Localized.Dominica

        case .dominicanRepublic:
            return Localized.DominicanRepublic

        case .ecuador:
            return Localized.Ecuador

        case .egypt:
            return Localized.Egypt

        case .elSalvador:
            return Localized.ElSalvador

        case .equatorialGuinea:
            return Localized.EquatorialGuinea

        case .eritrea:
            return Localized.Eritrea

        case .estonia:
            return Localized.Estonia

        case .ethiopia:
            return Localized.Ethiopia

        case .fiji:
            return Localized.Fiji

        case .finland:
            return Localized.Finland

        case .france:
            return Localized.France

        case .gabon:
            return Localized.Gabon

        case .gambia:
            return Localized.Gambia

        case .georgia:
            return Localized.Georgia

        case .germany:
            return Localized.Germany

        case .ghana:
            return Localized.Ghana

        case .greece:
            return Localized.Greece

        case .grenada:
            return Localized.Grenada

        case .guatemala:
            return Localized.Guatemala

        case .guinea:
            return Localized.Guinea

        case .guineaBissau:
            return Localized.GuineaBissau

        case .guyana:
            return Localized.Guyana

        case .haiti:
            return Localized.Haiti

        case .holySee:
            return Localized.HolySee

        case .honduras:
            return Localized.Honduras

        case .hongKong:
            return Localized.HongKong

        case .hungary:
            return Localized.Hungary

        case .iceland:
            return Localized.Iceland

        case .india:
            return Localized.India

        case .indonesia:
            return Localized.Indonesia

        case .iran:
            return Localized.Iran

        case .iraq:
            return Localized.Iraq

        case .ireland:
            return Localized.Ireland

        case .israel:
            return Localized.Israel

        case .italy:
            return Localized.Italy

        case .jamaica:
            return Localized.Jamaica

        case .japan:
            return Localized.Japan

        case .jordan:
            return Localized.Jordan

        case .kazakhstan:
            return Localized.Kazakhstan

        case .kenya:
            return Localized.Kenya

        case .kiribati:
            return Localized.Kiribati

        case .kosovo:
            return Localized.Kosovo

        case .kuwait:
            return Localized.Kuwait

        case .kyrgyzstan:
            return Localized.Kyrgyzstan

        case .laos:
            return Localized.Laos

        case .latvia:
            return Localized.Latvia

        case .lebanon:
            return Localized.Lebanon

        case .lesotho:
            return Localized.Lesotho

        case .liberia:
            return Localized.Liberia

        case .libya:
            return Localized.Libya

        case .liechtenstein:
            return Localized.Liechtenstein

        case .lithuania:
            return Localized.Lithuania

        case .luxembourg:
            return Localized.Luxembourg

        case .macau:
            return Localized.Macau

        case .macedonia:
            return Localized.Macedonia

        case .madagascar:
            return Localized.Madagascar

        case .malawi:
            return Localized.Malawi

        case .malaysia:
            return Localized.Malaysia

        case .maldives:
            return Localized.Maldives

        case .mali:
            return Localized.Mali

        case .malta:
            return Localized.Malta

        case .marshallIslands:
            return Localized.MarshallIslands

        case .mauritania:
            return Localized.Mauritania

        case .mauritius:
            return Localized.Mauritius

        case .mexico:
            return Localized.Mexico

        case .micronesia:
            return Localized.Micronesia

        case .moldova:
            return Localized.Moldova

        case .monaco:
            return Localized.Monaco

        case .mongolia:
            return Localized.Mongolia

        case .montenegro:
            return Localized.Montenegro

        case .morocco:
            return Localized.Morocco

        case .mozambique:
            return Localized.Mozambique

        case .namibia:
            return Localized.Namibia

        case .nauru:
            return Localized.Nauru

        case .nepal:
            return Localized.Nepal

        case .netherlands:
            return Localized.Netherlands

        case .newZealand:
            return Localized.NewZealand

        case .nicaragua:
            return Localized.Nicaragua

        case .niger:
            return Localized.Niger

        case .nigeria:
            return Localized.Nigeria

        case .northKorea:
            return Localized.NorthKorea

        case .norway:
            return Localized.Norway

        case .oman:
            return Localized.Oman

        case .pakistan:
            return Localized.Pakistan

        case .palau:
            return Localized.Palau

        case .palestinianTerritories:
            return Localized.PalestinianTerritories

        case .panama:
            return Localized.Panama

        case .papuaNewGuinea:
            return Localized.PapuaNewGuinea

        case .paraguay:
            return Localized.Paraguay

        case .peru:
            return Localized.Peru

        case .philippines:
            return Localized.Philippines

        case .poland:
            return Localized.Poland

        case .portugal:
            return Localized.Portugal

        case .qatar:
            return Localized.Qatar

        case .republicOfTheCongo:
            return Localized.RepublicOfTheCongo

        case .romania:
            return Localized.Romania

        case .russia:
            return Localized.Russia

        case .rwanda:
            return Localized.Rwanda

        case .saintKittsAndNevis:
            return Localized.SaintKittsAndNevis

        case .saintLucia:
            return Localized.SaintLucia

        case .saintVincentAndTheGrenadines:
            return Localized.SaintVincentAndTheGrenadines

        case .samoa:
            return Localized.Samoa

        case .sanMarino:
            return Localized.SanMarino

        case .saoTomeAndPrincipe:
            return Localized.SaoTomeAndPrincipe

        case .saudiArabia:
            return Localized.SaudiArabia

        case .senegal:
            return Localized.Senegal

        case .serbia:
            return Localized.Serbia

        case .seychelles:
            return Localized.Seychelles

        case .sierraLeone:
            return Localized.SierraLeone

        case .singapore:
            return Localized.Singapore

        case .sintMaarten:
            return Localized.SintMaarten

        case .slovakia:
            return Localized.Slovakia

        case .slovenia:
            return Localized.Slovenia

        case .solomonIslands:
            return Localized.SolomonIslands

        case .somalia:
            return Localized.Somalia

        case .southAfrica:
            return Localized.SouthAfrica
            
        case .southKorea:
            return Localized.SouthKorea
            
        case .southSudan:
            return Localized.SouthSudan
            
        case .spain:
            return Localized.Spain
            
        case .sriLanka:
            return Localized.SriLanka
            
        case .sudan:
            return Localized.Sudan
            
        case .suriname:
            return Localized.Suriname
            
        case .swaziland:
            return Localized.Swaziland
            
        case .sweden:
            return Localized.Sweden
            
        case .switzerland:
            return Localized.Switzerland
            
        case .syria:
            return Localized.Syria
            
        case .taiwan:
            return Localized.Taiwan
            
        case .tajikistan:
            return Localized.Tajikistan
            
        case .tanzania:
            return Localized.Tanzania
            
        case .thailand:
            return Localized.Thailand
            
        case .timorLeste:
            return Localized.TimorLeste
            
        case .togo:
            return Localized.Togo
            
        case .tonga:
            return Localized.Tonga
            
        case .trinidadAndTobago:
            return Localized.TrinidadAndTobago
            
        case .tunisia:
            return Localized.Tunisia
            
        case .turkey:
            return Localized.Turkey
            
        case .turkmenistan:
            return Localized.Turkmenistan
            
        case .tuvalu:
            return Localized.Tuvalu
            
        case .uganda:
            return Localized.Uganda
            
        case .ukraine:
            return Localized.Ukraine
            
        case .unitedArabEmirates:
            return Localized.UnitedArabEmirates
            
        case .unitedKingdom:
            return Localized.UnitedKingdom
            
        case .unitedStatesOfAmerica:
            return Localized.UnitedStatesOfAmerica
            
        case .uruguay:
            return Localized.Uruguay
            
        case .uzbekistan:
            return Localized.Uzbekistan
            
        case .vanuatu:
            return Localized.Vanuatu
            
        case .venezuela:
            return Localized.Venezuela
            
        case .vietnam:
            return Localized.Vietnam
            
        case .yemen:
            return Localized.Yemen
            
        case .zambia:
            return Localized.Zambia
            
        case .zimbabwe:
            return Localized.Zimbabwe
        }
    }
    
}

// MARK: - LanguageName

extension LanguageName {

    private typealias Localized = String.Localized.LanguageName

    var localized: String {
        switch self {
        case .none:
            return Localized.None

        case .afrikaans:
            return Localized.Afrikaans

        case .albanian:
            return Localized.Albanian

        case .amharic:
            return Localized.Amharic

        case .arabic:
            return Localized.Arabic

        case .aramaic:
            return Localized.Aramaic

        case .armenian:
            return Localized.Armenian

        case .assamese:
            return Localized.Assamese

        case .aymara:
            return Localized.Aymara

        case .azerbaijani:
            return Localized.Azerbaijani

        case .balochi:
            return Localized.Balochi

        case .bamanankan:
            return Localized.Bamanankan

        case .bashkir:
            return Localized.Bashkir

        case .basque:
            return Localized.Basque

        case .belarusian:
            return Localized.Belarusian

        case .bengali:
            return Localized.Bengali

        case .bhojpuri:
            return Localized.Bhojpuri

        case .bislama:
            return Localized.Bislama

        case .bosnian:
            return Localized.Bosnian

        case .brahui:
            return Localized.Brahui

        case .bulgarian:
            return Localized.Bulgarian

        case .burmese:
            return Localized.Burmese

        case .cantonese:
            return Localized.Cantonese

        case .catalan:
            return Localized.Catalan

        case .cebuano:
            return Localized.Cebuano

        case .chechen:
            return Localized.Chechen

        case .cherokee:
            return Localized.Cherokee

        case .croatian:
            return Localized.Croatian

        case .czech:
            return Localized.Czech

        case .dakota:
            return Localized.Dakota

        case .danish:
            return Localized.Danish

        case .dari:
            return Localized.Dari

        case .dholuo:
            return Localized.Dholuo

        case .dutch:
            return Localized.Dutch

        case .english:
            return Localized.English

        case .esperanto:
            return Localized.Esperanto

        case .estonian:
            return Localized.Estonian

        case .ewe:
            return Localized.Ewe

        case .finnish:
            return Localized.Finnish

        case .french:
            return Localized.French

        case .georgian:
            return Localized.Georgian

        case .german:
            return Localized.German

        case .gikuyu:
            return Localized.Gikuyu

        case .greek:
            return Localized.Greek

        case .guarani:
            return Localized.Guarani

        case .gujarati:
            return Localized.Gujarati

        case .haitianCreole:
            return Localized.HaitianCreole

        case .hausa:
            return Localized.Hausa

        case .hawaiian:
            return Localized.Hawaiian

        case .hebrew:
            return Localized.Hebrew

        case .hiligaynon:
            return Localized.Hiligaynon

        case .hindi:
            return Localized.Hindi

        case .hungarian:
            return Localized.Hungarian

        case .icelandic:
            return Localized.Icelandic

        case .igbo:
            return Localized.Igbo

        case .ilocano:
            return Localized.Ilocano

        case .indonesian:
            return Localized.Indonesian

        case .inuit:
            return Localized.Inuit

        case .irishGaelic:
            return Localized.IrishGaelic

        case .italian:
            return Localized.Italian

        case .japanese:
            return Localized.Japanese

        case .jarai:
            return Localized.Jarai

        case .javanese:
            return Localized.Javanese

        case .kiche:
            return Localized.Kiche

        case .kabyle:
            return Localized.Kabyle

        case .kannada:
            return Localized.Kannada

        case .kashmiri:
            return Localized.Kashmiri

        case .kazakh:
            return Localized.Kazakh

        case .khmer:
            return Localized.Khmer

        case .khoekhoe:
            return Localized.Khoekhoe

        case .korean:
            return Localized.Korean

        case .kurdish:
            return Localized.Kurdish

        case .kyrgyz:
            return Localized.Kyrgyz

        case .lao:
            return Localized.Lao

        case .latin:
            return Localized.Latin

        case .latvian:
            return Localized.Latvian

        case .lingala:
            return Localized.Lingala

        case .lithuanian:
            return Localized.Lithuanian

        case .macedonian:
            return Localized.Macedonian

        case .maithili:
            return Localized.Maithili

        case .malagasy:
            return Localized.Malagasy

        case .malay:
            return Localized.Malay

        case .malayalam:
            return Localized.Malayalam

        case .mandarin:
            return Localized.Mandarin

        case .marathi:
            return Localized.Marathi

        case .mende:
            return Localized.Mende

        case .mongolian:
            return Localized.Mongolian

        case .nahuatl:
            return Localized.Nahuatl

        case .navajo:
            return Localized.Navajo

        case .nepali:
            return Localized.Nepali

        case .norwegian:
            return Localized.Norwegian

        case .ojibwa:
            return Localized.Ojibwa

        case .oriya:
            return Localized.Oriya

        case .oromo:
            return Localized.Oromo

        case .pashto:
            return Localized.Pashto

        case .persian:
            return Localized.Persian

        case .polish:
            return Localized.Polish

        case .portuguese:
            return Localized.Portuguese

        case .punjabi:
            return Localized.Punjabi

        case .quechua:
            return Localized.Quechua

        case .romani:
            return Localized.Romani

        case .romanian:
            return Localized.Romanian

        case .russian:
            return Localized.Russian

        case .rwanda:
            return Localized.Rwanda

        case .samoan:
            return Localized.Samoan

        case .sanskrit:
            return Localized.Sanskrit

        case .serbian:
            return Localized.Serbian

        case .shona:
            return Localized.Shona

        case .sindhi:
            return Localized.Sindhi

        case .sinhala:
            return Localized.Sinhala

        case .slovak:
            return Localized.Slovak

        case .slovene:
            return Localized.Slovene

        case .somali:
            return Localized.Somali

        case .spanish:
            return Localized.Spanish

        case .swahili:
            return Localized.Swahili

        case .swedish:
            return Localized.Swedish
            
        case .tachelhit:
            return Localized.Tachelhit
            
        case .tagalog:
            return Localized.Tagalog
            
        case .tajiki:
            return Localized.Tajiki
            
        case .tamil:
            return Localized.Tamil
            
        case .tatar:
            return Localized.Tatar
            
        case .telugu:
            return Localized.Telugu
            
        case .thai:
            return Localized.Thai
            
        case .tigrigna:
            return Localized.Tigrigna
            
        case .tokPisin:
            return Localized.TokPisin
            
        case .turkish:
            return Localized.Turkish
            
        case .turkmen:
            return Localized.Turkmen
            
        case .ukrainian:
            return Localized.Ukrainian
            
        case .urdu:
            return Localized.Urdu
            
        case .uyghur:
            return Localized.Uyghur
            
        case .uzbek:
            return Localized.Uzbek
            
        case .vietnamese:
            return Localized.Vietnamese
            
        case .warlpiri:
            return Localized.Warlpiri
            
        case .welsh:
            return Localized.Welsh
            
        case .wolof:
            return Localized.Wolof
            
        case .xhosa:
            return Localized.Xhosa
            
        case .yakut:
            return Localized.Yakut
            
        case .yiddish:
            return Localized.Yiddish
            
        case .yoruba:
            return Localized.Yoruba
            
        case .yucatec:
            return Localized.Yucatec
            
        case .zapotec:
            return Localized.Zapotec
            
        case .zulu:
            return Localized.Zulu
        }
    }

}

// MARK: - LanguageLevel

extension LanguageLevel {

    private typealias Localized = String.Localized.LanguageLevel

    var localized: String {
        switch self {
        case .none:
            return Localized.None

        case .beginner:
            return Localized.Beginner

        case .intermediate:
            return Localized.Intermediate

        case .advanced:
            return Localized.Advanced

        case .fluent:
            return Localized.Fluent

        case .native:
            return Localized.Native
        }
    }

}
