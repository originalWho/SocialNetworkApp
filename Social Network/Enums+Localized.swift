import Foundation

// MARK: - Gender

extension Gender {

    private typealias Localized = String.Localized.Gender

    var localized: String {
        switch self {
        case .None:
            return Localized.None

        case .Male:
            return Localized.Male

        case .Female:
            return Localized.Female
        }
    }

}

// MARK: - Country

extension Country {

    private typealias Localized = String.Localized.Country

    var localized: String {
        switch self {
        case .None:
            return Localized.None

        case .Afghanistan:
            return Localized.Afghanistan

        case .Albania:
            return Localized.Albania

        case .Algeria:
            return Localized.Algeria

        case .Andorra:
            return Localized.Andorra

        case .Angola:
            return Localized.Angola

        case .AntiguaAndBarbuda:
            return Localized.AntiguaAndBarbuda

        case .Argentina:
            return Localized.Argentina

        case .Armenia:
            return Localized.Armenia

        case .Aruba:
            return Localized.Aruba

        case .Australia:
            return Localized.Australia

        case .Austria:
            return Localized.Austria

        case .Azerbaijan:
            return Localized.Azerbaijan

        case .Bahamas:
            return Localized.Bahamas

        case .Bahrain:
            return Localized.Bahrain

        case .Bangladesh:
            return Localized.Bangladesh

        case .Barbados:
            return Localized.Barbados

        case .Belarus:
            return Localized.Belarus

        case .Belgium:
            return Localized.Belgium

        case .Belize:
            return Localized.Belize

        case .Benin:
            return Localized.Benin

        case .Bhutan:
            return Localized.Bhutan

        case .Bolivia:
            return Localized.Bolivia

        case .BosniaAndHerzegovina:
            return Localized.BosniaAndHerzegovina

        case .Botswana:
            return Localized.Botswana

        case .Brazil:
            return Localized.Brazil

        case .Brunei:
            return Localized.Brunei

        case .Bulgaria:
            return Localized.Bulgaria

        case .BurkinaFaso:
            return Localized.BurkinaFaso

        case .Burma:
            return Localized.Burma

        case .Burundi:
            return Localized.Burundi

        case .Cambodia:
            return Localized.Cambodia

        case .Cameroon:
            return Localized.Cameroon

        case .Canada:
            return Localized.Canada

        case .CaboVerde:
            return Localized.CaboVerde

        case .CentralAfricanRepublic:
            return Localized.CentralAfricanRepublic

        case .Chad:
            return Localized.Chad

        case .Chile:
            return Localized.Chile

        case .China:
            return Localized.China

        case .Colombia:
            return Localized.Colombia

        case .Comoros:
            return Localized.Comoros

        case .CostaRica:
            return Localized.CostaRica

        case .CotedIvoire:
            return Localized.CotedIvoire

        case .Croatia:
            return Localized.Croatia

        case .Cuba:
            return Localized.Cuba

        case .Curacao:
            return Localized.Curacao

        case .Cyprus:
            return Localized.Cyprus

        case .Czechia:
            return Localized.Czechia

        case .DemocraticRepublicOfTheCongo:
            return Localized.DemocraticRepublicOfTheCongo

        case .Denmark:
            return Localized.Denmark

        case .Djibouti:
            return Localized.Djibouti

        case .Dominica:
            return Localized.Dominica

        case .DominicanRepublic:
            return Localized.DominicanRepublic

        case .Ecuador:
            return Localized.Ecuador

        case .Egypt:
            return Localized.Egypt

        case .ElSalvador:
            return Localized.ElSalvador

        case .EquatorialGuinea:
            return Localized.EquatorialGuinea

        case .Eritrea:
            return Localized.Eritrea

        case .Estonia:
            return Localized.Estonia

        case .Ethiopia:
            return Localized.Ethiopia

        case .Fiji:
            return Localized.Fiji

        case .Finland:
            return Localized.Finland

        case .France:
            return Localized.France

        case .Gabon:
            return Localized.Gabon

        case .Gambia:
            return Localized.Gambia

        case .Georgia:
            return Localized.Georgia

        case .Germany:
            return Localized.Germany

        case .Ghana:
            return Localized.Ghana

        case .Greece:
            return Localized.Greece

        case .Grenada:
            return Localized.Grenada

        case .Guatemala:
            return Localized.Guatemala

        case .Guinea:
            return Localized.Guinea

        case .GuineaBissau:
            return Localized.GuineaBissau

        case .Guyana:
            return Localized.Guyana

        case .Haiti:
            return Localized.Haiti

        case .HolySee:
            return Localized.HolySee

        case .Honduras:
            return Localized.Honduras

        case .HongKong:
            return Localized.HongKong

        case .Hungary:
            return Localized.Hungary

        case .Iceland:
            return Localized.Iceland

        case .India:
            return Localized.India

        case .Indonesia:
            return Localized.Indonesia

        case .Iran:
            return Localized.Iran

        case .Iraq:
            return Localized.Iraq

        case .Ireland:
            return Localized.Ireland

        case .Israel:
            return Localized.Israel

        case .Italy:
            return Localized.Italy

        case .Jamaica:
            return Localized.Jamaica

        case .Japan:
            return Localized.Japan

        case .Jordan:
            return Localized.Jordan

        case .Kazakhstan:
            return Localized.Kazakhstan

        case .Kenya:
            return Localized.Kenya

        case .Kiribati:
            return Localized.Kiribati

        case .Kosovo:
            return Localized.Kosovo

        case .Kuwait:
            return Localized.Kuwait

        case .Kyrgyzstan:
            return Localized.Kyrgyzstan

        case .Laos:
            return Localized.Laos

        case .Latvia:
            return Localized.Latvia

        case .Lebanon:
            return Localized.Lebanon

        case .Lesotho:
            return Localized.Lesotho

        case .Liberia:
            return Localized.Liberia

        case .Libya:
            return Localized.Libya

        case .Liechtenstein:
            return Localized.Liechtenstein

        case .Lithuania:
            return Localized.Lithuania

        case .Luxembourg:
            return Localized.Luxembourg

        case .Macau:
            return Localized.Macau

        case .Macedonia:
            return Localized.Macedonia

        case .Madagascar:
            return Localized.Madagascar

        case .Malawi:
            return Localized.Malawi

        case .Malaysia:
            return Localized.Malaysia

        case .Maldives:
            return Localized.Maldives

        case .Mali:
            return Localized.Mali

        case .Malta:
            return Localized.Malta

        case .MarshallIslands:
            return Localized.MarshallIslands

        case .Mauritania:
            return Localized.Mauritania

        case .Mauritius:
            return Localized.Mauritius

        case .Mexico:
            return Localized.Mexico

        case .Micronesia:
            return Localized.Micronesia

        case .Moldova:
            return Localized.Moldova

        case .Monaco:
            return Localized.Monaco

        case .Mongolia:
            return Localized.Mongolia

        case .Montenegro:
            return Localized.Montenegro

        case .Morocco:
            return Localized.Morocco

        case .Mozambique:
            return Localized.Mozambique

        case .Namibia:
            return Localized.Namibia

        case .Nauru:
            return Localized.Nauru

        case .Nepal:
            return Localized.Nepal

        case .Netherlands:
            return Localized.Netherlands

        case .NewZealand:
            return Localized.NewZealand

        case .Nicaragua:
            return Localized.Nicaragua

        case .Niger:
            return Localized.Niger

        case .Nigeria:
            return Localized.Nigeria

        case .NorthKorea:
            return Localized.NorthKorea

        case .Norway:
            return Localized.Norway

        case .Oman:
            return Localized.Oman

        case .Pakistan:
            return Localized.Pakistan

        case .Palau:
            return Localized.Palau

        case .PalestinianTerritories:
            return Localized.PalestinianTerritories

        case .Panama:
            return Localized.Panama

        case .PapuaNewGuinea:
            return Localized.PapuaNewGuinea

        case .Paraguay:
            return Localized.Paraguay

        case .Peru:
            return Localized.Peru

        case .Philippines:
            return Localized.Philippines

        case .Poland:
            return Localized.Poland

        case .Portugal:
            return Localized.Portugal

        case .Qatar:
            return Localized.Qatar

        case .RepublicOfTheCongo:
            return Localized.RepublicOfTheCongo

        case .Romania:
            return Localized.Romania

        case .Russia:
            return Localized.Russia

        case .Rwanda:
            return Localized.Rwanda

        case .SaintKittsAndNevis:
            return Localized.SaintKittsAndNevis

        case .SaintLucia:
            return Localized.SaintLucia

        case .SaintVincentAndTheGrenadines:
            return Localized.SaintVincentAndTheGrenadines

        case .Samoa:
            return Localized.Samoa

        case .SanMarino:
            return Localized.SanMarino

        case .SaoTomeAndPrincipe:
            return Localized.SaoTomeAndPrincipe

        case .SaudiArabia:
            return Localized.SaudiArabia

        case .Senegal:
            return Localized.Senegal

        case .Serbia:
            return Localized.Serbia

        case .Seychelles:
            return Localized.Seychelles

        case .SierraLeone:
            return Localized.SierraLeone

        case .Singapore:
            return Localized.Singapore

        case .SintMaarten:
            return Localized.SintMaarten

        case .Slovakia:
            return Localized.Slovakia

        case .Slovenia:
            return Localized.Slovenia

        case .SolomonIslands:
            return Localized.SolomonIslands

        case .Somalia:
            return Localized.Somalia

        case .SouthAfrica:
            return Localized.SouthAfrica
            
        case .SouthKorea:
            return Localized.SouthKorea
            
        case .SouthSudan:
            return Localized.SouthSudan
            
        case .Spain:
            return Localized.Spain
            
        case .SriLanka:
            return Localized.SriLanka
            
        case .Sudan:
            return Localized.Sudan
            
        case .Suriname:
            return Localized.Suriname
            
        case .Swaziland:
            return Localized.Swaziland
            
        case .Sweden:
            return Localized.Sweden
            
        case .Switzerland:
            return Localized.Switzerland
            
        case .Syria:
            return Localized.Syria
            
        case .Taiwan:
            return Localized.Taiwan
            
        case .Tajikistan:
            return Localized.Tajikistan
            
        case .Tanzania:
            return Localized.Tanzania
            
        case .Thailand:
            return Localized.Thailand
            
        case .TimorLeste:
            return Localized.TimorLeste
            
        case .Togo:
            return Localized.Togo
            
        case .Tonga:
            return Localized.Tonga
            
        case .TrinidadAndTobago:
            return Localized.TrinidadAndTobago
            
        case .Tunisia:
            return Localized.Tunisia
            
        case .Turkey:
            return Localized.Turkey
            
        case .Turkmenistan:
            return Localized.Turkmenistan
            
        case .Tuvalu:
            return Localized.Tuvalu
            
        case .Uganda:
            return Localized.Uganda
            
        case .Ukraine:
            return Localized.Ukraine
            
        case .UnitedArabEmirates:
            return Localized.UnitedArabEmirates
            
        case .UnitedKingdom:
            return Localized.UnitedKingdom
            
        case .UnitedStatesOfAmerica:
            return Localized.UnitedStatesOfAmerica
            
        case .Uruguay:
            return Localized.Uruguay
            
        case .Uzbekistan:
            return Localized.Uzbekistan
            
        case .Vanuatu:
            return Localized.Vanuatu
            
        case .Venezuela:
            return Localized.Venezuela
            
        case .Vietnam:
            return Localized.Vietnam
            
        case .Yemen:
            return Localized.Yemen
            
        case .Zambia:
            return Localized.Zambia
            
        case .Zimbabwe:
            return Localized.Zimbabwe
        }
    }
    
}

// MARK: - LanguageName

extension LanguageName {

    private typealias Localized = String.Localized.LanguageName

    var localized: String {
        switch self {
        case .None:
            return Localized.None

        case .Afrikaans:
            return Localized.Afrikaans

        case .Albanian:
            return Localized.Albanian

        case .Amharic:
            return Localized.Amharic

        case .Arabic:
            return Localized.Arabic

        case .Aramaic:
            return Localized.Aramaic

        case .Armenian:
            return Localized.Armenian

        case .Assamese:
            return Localized.Assamese

        case .Aymara:
            return Localized.Aymara

        case .Azerbaijani:
            return Localized.Azerbaijani

        case .Balochi:
            return Localized.Balochi

        case .Bamanankan:
            return Localized.Bamanankan

        case .Bashkir:
            return Localized.Bashkir

        case .Basque:
            return Localized.Basque

        case .Belarusian:
            return Localized.Belarusian

        case .Bengali:
            return Localized.Bengali

        case .Bhojpuri:
            return Localized.Bhojpuri

        case .Bislama:
            return Localized.Bislama

        case .Bosnian:
            return Localized.Bosnian

        case .Brahui:
            return Localized.Brahui

        case .Bulgarian:
            return Localized.Bulgarian

        case .Burmese:
            return Localized.Burmese

        case .Cantonese:
            return Localized.Cantonese

        case .Catalan:
            return Localized.Catalan

        case .Cebuano:
            return Localized.Cebuano

        case .Chechen:
            return Localized.Chechen

        case .Cherokee:
            return Localized.Cherokee

        case .Croatian:
            return Localized.Croatian

        case .Czech:
            return Localized.Czech

        case .Dakota:
            return Localized.Dakota

        case .Danish:
            return Localized.Danish

        case .Dari:
            return Localized.Dari

        case .Dholuo:
            return Localized.Dholuo

        case .Dutch:
            return Localized.Dutch

        case .English:
            return Localized.English

        case .Esperanto:
            return Localized.Esperanto

        case .Estonian:
            return Localized.Estonian

        case .Ewe:
            return Localized.Ewe

        case .Finnish:
            return Localized.Finnish

        case .French:
            return Localized.French

        case .Georgian:
            return Localized.Georgian

        case .German:
            return Localized.German

        case .Gikuyu:
            return Localized.Gikuyu

        case .Greek:
            return Localized.Greek

        case .Guarani:
            return Localized.Guarani

        case .Gujarati:
            return Localized.Gujarati

        case .HaitianCreole:
            return Localized.HaitianCreole

        case .Hausa:
            return Localized.Hausa

        case .Hawaiian:
            return Localized.Hawaiian

        case .Hebrew:
            return Localized.Hebrew

        case .Hiligaynon:
            return Localized.Hiligaynon

        case .Hindi:
            return Localized.Hindi

        case .Hungarian:
            return Localized.Hungarian

        case .Icelandic:
            return Localized.Icelandic

        case .Igbo:
            return Localized.Igbo

        case .Ilocano:
            return Localized.Ilocano

        case .Indonesian:
            return Localized.Indonesian

        case .Inuit:
            return Localized.Inuit

        case .IrishGaelic:
            return Localized.IrishGaelic

        case .Italian:
            return Localized.Italian

        case .Japanese:
            return Localized.Japanese

        case .Jarai:
            return Localized.Jarai

        case .Javanese:
            return Localized.Javanese

        case .Kiche:
            return Localized.Kiche

        case .Kabyle:
            return Localized.Kabyle

        case .Kannada:
            return Localized.Kannada

        case .Kashmiri:
            return Localized.Kashmiri

        case .Kazakh:
            return Localized.Kazakh

        case .Khmer:
            return Localized.Khmer

        case .Khoekhoe:
            return Localized.Khoekhoe

        case .Korean:
            return Localized.Korean

        case .Kurdish:
            return Localized.Kurdish

        case .Kyrgyz:
            return Localized.Kyrgyz

        case .Lao:
            return Localized.Lao

        case .Latin:
            return Localized.Latin

        case .Latvian:
            return Localized.Latvian

        case .Lingala:
            return Localized.Lingala

        case .Lithuanian:
            return Localized.Lithuanian

        case .Macedonian:
            return Localized.Macedonian

        case .Maithili:
            return Localized.Maithili

        case .Malagasy:
            return Localized.Malagasy

        case .Malay:
            return Localized.Malay

        case .Malayalam:
            return Localized.Malayalam

        case .Mandarin:
            return Localized.Mandarin

        case .Marathi:
            return Localized.Marathi

        case .Mende:
            return Localized.Mende

        case .Mongolian:
            return Localized.Mongolian

        case .Nahuatl:
            return Localized.Nahuatl

        case .Navajo:
            return Localized.Navajo

        case .Nepali:
            return Localized.Nepali

        case .Norwegian:
            return Localized.Norwegian

        case .Ojibwa:
            return Localized.Ojibwa

        case .Oriya:
            return Localized.Oriya

        case .Oromo:
            return Localized.Oromo

        case .Pashto:
            return Localized.Pashto

        case .Persian:
            return Localized.Persian

        case .Polish:
            return Localized.Polish

        case .Portuguese:
            return Localized.Portuguese

        case .Punjabi:
            return Localized.Punjabi

        case .Quechua:
            return Localized.Quechua

        case .Romani:
            return Localized.Romani

        case .Romanian:
            return Localized.Romanian

        case .Russian:
            return Localized.Russian

        case .Rwanda:
            return Localized.Rwanda

        case .Samoan:
            return Localized.Samoan

        case .Sanskrit:
            return Localized.Sanskrit

        case .Serbian:
            return Localized.Serbian

        case .Shona:
            return Localized.Shona

        case .Sindhi:
            return Localized.Sindhi

        case .Sinhala:
            return Localized.Sinhala

        case .Slovak:
            return Localized.Slovak

        case .Slovene:
            return Localized.Slovene

        case .Somali:
            return Localized.Somali

        case .Spanish:
            return Localized.Spanish

        case .Swahili:
            return Localized.Swahili

        case .Swedish:
            return Localized.Swedish
            
        case .Tachelhit:
            return Localized.Tachelhit
            
        case .Tagalog:
            return Localized.Tagalog
            
        case .Tajiki:
            return Localized.Tajiki
            
        case .Tamil:
            return Localized.Tamil
            
        case .Tatar:
            return Localized.Tatar
            
        case .Telugu:
            return Localized.Telugu
            
        case .Thai:
            return Localized.Thai
            
        case .Tigrigna:
            return Localized.Tigrigna
            
        case .TokPisin:
            return Localized.TokPisin
            
        case .Turkish:
            return Localized.Turkish
            
        case .Turkmen:
            return Localized.Turkmen
            
        case .Ukrainian:
            return Localized.Ukrainian
            
        case .Urdu:
            return Localized.Urdu
            
        case .Uyghur:
            return Localized.Uyghur
            
        case .Uzbek:
            return Localized.Uzbek
            
        case .Vietnamese:
            return Localized.Vietnamese
            
        case .Warlpiri:
            return Localized.Warlpiri
            
        case .Welsh:
            return Localized.Welsh
            
        case .Wolof:
            return Localized.Wolof
            
        case .Xhosa:
            return Localized.Xhosa
            
        case .Yakut:
            return Localized.Yakut
            
        case .Yiddish:
            return Localized.Yiddish
            
        case .Yoruba:
            return Localized.Yoruba
            
        case .Yucatec:
            return Localized.Yucatec
            
        case .Zapotec:
            return Localized.Zapotec
            
        case .Zulu:
            return Localized.Zulu
        }
    }

}

// MARK: - LanguageLevel

extension LanguageLevel {

    private typealias Localized = String.Localized.LanguageLevel

    var localized: String {
        switch self {
        case .None:
            return Localized.None

        case .Beginner:
            return Localized.Beginner

        case .Intermediate:
            return Localized.Intermediate

        case .Advanced:
            return Localized.Advanced

        case .Fluent:
            return Localized.Fluent

        case .Native:
            return Localized.Native
        }
    }

}
