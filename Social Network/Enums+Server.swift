import Foundation

extension Gender {

    private typealias Server = String.Server.Gender

    init(stringValue: String) {
        switch stringValue {
        case Server.Male:
            self = .male

        case Server.Female:
            self = .female

        default:
            self = .none
        }
    }

    var stringValue: String {
        switch self {
        case .none:
            return Server.None

        case .male:
            return Server.Male

        case .female:
            return Server.Female
        }
    }

}

extension Country {

    private typealias Server = String.Server.Country

    init(stringValue: String) {
        switch stringValue {
        case Server.Afghanistan:
            self = .afghanistan

        case Server.Albania:
            self = .albania

        case Server.Algeria:
            self = .algeria

        case Server.Andorra:
            self = .andorra

        case Server.Angola:
            self = .angola

        case Server.AntiguaAndBarbuda:
            self = .antiguaAndBarbuda

        case Server.Argentina:
            self = .argentina

        case Server.Armenia:
            self = .armenia

        case Server.Aruba:
            self = .aruba

        case Server.Australia:
            self = .australia

        case Server.Austria:
            self = .austria

        case Server.Azerbaijan:
            self = .azerbaijan

        case Server.Bahamas:
            self = .bahamas

        case Server.Bahrain:
            self = .bahrain

        case Server.Bangladesh:
            self = .bangladesh

        case Server.Barbados:
            self = .barbados

        case Server.Belarus:
            self = .belarus

        case Server.Belgium:
            self = .belgium

        case Server.Belize:
            self = .belize

        case Server.Benin:
            self = .benin

        case Server.Bhutan:
            self = .bhutan

        case Server.Bolivia:
            self = .bolivia

        case Server.BosniaAndHerzegovina:
            self = .bosniaAndHerzegovina

        case Server.Botswana:
            self = .botswana

        case Server.Brazil:
            self = .brazil

        case Server.Brunei:
            self = .brunei

        case Server.Bulgaria:
            self = .bulgaria

        case Server.BurkinaFaso:
            self = .burkinaFaso

        case Server.Burma:
            self = .burma

        case Server.Burundi:
            self = .burundi

        case Server.Cambodia:
            self = .cambodia

        case Server.Cameroon:
            self = .cameroon

        case Server.Canada:
            self = .canada

        case Server.CaboVerde:
            self = .caboVerde

        case Server.CentralAfricanRepublic:
            self = .centralAfricanRepublic

        case Server.Chad:
            self = .chad

        case Server.Chile:
            self = .chile

        case Server.China:
            self = .china

        case Server.Colombia:
            self = .colombia

        case Server.Comoros:
            self = .comoros

        case Server.CostaRica:
            self = .costaRica

        case Server.CotedIvoire:
            self = .cotedIvoire

        case Server.Croatia:
            self = .croatia

        case Server.Cuba:
            self = .cuba

        case Server.Curacao:
            self = .curacao

        case Server.Cyprus:
            self = .cyprus

        case Server.Czechia:
            self = .czechia

        case Server.DemocraticRepublicOfTheCongo:
            self = .democraticRepublicOfTheCongo

        case Server.Denmark:
            self = .denmark

        case Server.Djibouti:
            self = .djibouti

        case Server.Dominica:
            self = .dominica

        case Server.DominicanRepublic:
            self = .dominicanRepublic

        case Server.Ecuador:
            self = .ecuador

        case Server.Egypt:
            self = .egypt

        case Server.ElSalvador:
            self = .elSalvador

        case Server.EquatorialGuinea:
            self = .equatorialGuinea

        case Server.Eritrea:
            self = .eritrea

        case Server.Estonia:
            self = .estonia

        case Server.Ethiopia:
            self = .ethiopia

        case Server.Fiji:
            self = .fiji

        case Server.Finland:
            self = .finland

        case Server.France:
            self = .france

        case Server.Gabon:
            self = .gabon

        case Server.Gambia:
            self = .gambia

        case Server.Georgia:
            self = .georgia

        case Server.Germany:
            self = .germany

        case Server.Ghana:
            self = .ghana

        case Server.Greece:
            self = .greece

        case Server.Grenada:
            self = .grenada

        case Server.Guatemala:
            self = .guatemala

        case Server.Guinea:
            self = .guinea

        case Server.GuineaBissau:
            self = .guineaBissau

        case Server.Guyana:
            self = .guyana

        case Server.Haiti:
            self = .haiti

        case Server.HolySee:
            self = .holySee

        case Server.Honduras:
            self = .honduras

        case Server.HongKong:
            self = .hongKong

        case Server.Hungary:
            self = .hungary

        case Server.Iceland:
            self = .iceland

        case Server.India:
            self = .india

        case Server.Indonesia:
            self = .indonesia

        case Server.Iran:
            self = .iran

        case Server.Iraq:
            self = .iraq

        case Server.Ireland:
            self = .ireland

        case Server.Israel:
            self = .israel

        case Server.Italy:
            self = .italy

        case Server.Jamaica:
            self = .jamaica

        case Server.Japan:
            self = .japan

        case Server.Jordan:
            self = .jordan

        case Server.Kazakhstan:
            self = .kazakhstan

        case Server.Kenya:
            self = .kenya

        case Server.Kiribati:
            self = .kiribati

        case Server.Kosovo:
            self = .kosovo

        case Server.Kuwait:
            self = .kuwait

        case Server.Kyrgyzstan:
            self = .kyrgyzstan

        case Server.Laos:
            self = .laos

        case Server.Latvia:
            self = .latvia

        case Server.Lebanon:
            self = .lebanon

        case Server.Lesotho:
            self = .lesotho

        case Server.Liberia:
            self = .liberia

        case Server.Libya:
            self = .libya

        case Server.Liechtenstein:
            self = .liechtenstein

        case Server.Lithuania:
            self = .lithuania

        case Server.Luxembourg:
            self = .luxembourg

        case Server.Macau:
            self = .macau

        case Server.Macedonia:
            self = .macedonia

        case Server.Madagascar:
            self = .madagascar

        case Server.Malawi:
            self = .malawi

        case Server.Malaysia:
            self = .malaysia

        case Server.Maldives:
            self = .maldives

        case Server.Mali:
            self = .mali

        case Server.Malta:
            self = .malta

        case Server.MarshallIslands:
            self = .marshallIslands

        case Server.Mauritania:
            self = .mauritania

        case Server.Mauritius:
            self = .mauritius

        case Server.Mexico:
            self = .mexico

        case Server.Micronesia:
            self = .micronesia

        case Server.Moldova:
            self = .moldova

        case Server.Monaco:
            self = .monaco

        case Server.Mongolia:
            self = .mongolia

        case Server.Montenegro:
            self = .montenegro

        case Server.Morocco:
            self = .morocco

        case Server.Mozambique:
            self = .mozambique

        case Server.Namibia:
            self = .namibia

        case Server.Nauru:
            self = .nauru

        case Server.Nepal:
            self = .nepal

        case Server.Netherlands:
            self = .netherlands

        case Server.NewZealand:
            self = .newZealand

        case Server.Nicaragua:
            self = .nicaragua

        case Server.Niger:
            self = .niger

        case Server.Nigeria:
            self = .nigeria

        case Server.NorthKorea:
            self = .northKorea

        case Server.Norway:
            self = .norway

        case Server.Oman:
            self = .oman

        case Server.Pakistan:
            self = .pakistan

        case Server.Palau:
            self = .palau

        case Server.PalestinianTerritories:
            self = .palestinianTerritories

        case Server.Panama:
            self = .panama

        case Server.PapuaNewGuinea:
            self = .papuaNewGuinea

        case Server.Paraguay:
            self = .paraguay

        case Server.Peru:
            self = .peru

        case Server.Philippines:
            self = .philippines

        case Server.Poland:
            self = .poland

        case Server.Portugal:
            self = .portugal

        case Server.Qatar:
            self = .qatar

        case Server.RepublicOfTheCongo:
            self = .republicOfTheCongo

        case Server.Romania:
            self = .romania

        case Server.Russia:
            self = .russia

        case Server.Rwanda:
            self = .rwanda

        case Server.SaintKittsAndNevis:
            self = .saintKittsAndNevis

        case Server.SaintLucia:
            self = .saintLucia

        case Server.SaintVincentAndTheGrenadines:
            self = .saintVincentAndTheGrenadines

        case Server.Samoa:
            self = .samoa

        case Server.SanMarino:
            self = .sanMarino

        case Server.SaoTomeAndPrincipe:
            self = .saoTomeAndPrincipe

        case Server.SaudiArabia:
            self = .saudiArabia

        case Server.Senegal:
            self = .senegal

        case Server.Serbia:
            self = .serbia

        case Server.Seychelles:
            self = .seychelles

        case Server.SierraLeone:
            self = .sierraLeone

        case Server.Singapore:
            self = .singapore

        case Server.SintMaarten:
            self = .sintMaarten

        case Server.Slovakia:
            self = .slovakia

        case Server.Slovenia:
            self = .slovenia

        case Server.SolomonIslands:
            self = .solomonIslands

        case Server.Somalia:
            self = .somalia

        case Server.SouthAfrica:
            self = .southAfrica

        case Server.SouthKorea:
            self = .southKorea

        case Server.SouthSudan:
            self = .southSudan

        case Server.Spain:
            self = .spain

        case Server.SriLanka:
            self = .sriLanka
            
        case Server.Sudan:
            self = .sudan
            
        case Server.Suriname:
            self = .suriname
            
        case Server.Swaziland:
            self = .swaziland
            
        case Server.Sweden:
            self = .sweden
            
        case Server.Switzerland:
            self = .switzerland
            
        case Server.Syria:
            self = .syria
            
        case Server.Taiwan:
            self = .taiwan
            
        case Server.Tajikistan:
            self = .tajikistan
            
        case Server.Tanzania:
            self = .tanzania
            
        case Server.Thailand:
            self = .thailand
            
        case Server.TimorLeste:
            self = .timorLeste
            
        case Server.Togo:
            self = .togo
            
        case Server.Tonga:
            self = .tonga
            
        case Server.TrinidadAndTobago:
            self = .trinidadAndTobago
            
        case Server.Tunisia:
            self = .tunisia
            
        case Server.Turkey:
            self = .turkey
            
        case Server.Turkmenistan:
            self = .turkmenistan
            
        case Server.Tuvalu:
            self = .tuvalu
            
        case Server.Uganda:
            self = .uganda
            
        case Server.Ukraine:
            self = .ukraine
            
        case Server.UnitedArabEmirates:
            self = .unitedArabEmirates
            
        case Server.UnitedKingdom:
            self = .unitedKingdom
            
        case Server.UnitedStatesOfAmerica:
            self = .unitedStatesOfAmerica
            
        case Server.Uruguay:
            self = .uruguay
            
        case Server.Uzbekistan:
            self = .uzbekistan
            
        case Server.Vanuatu:
            self = .vanuatu
            
        case Server.Venezuela:
            self = .venezuela
            
        case Server.Vietnam:
            self = .vietnam
            
        case Server.Yemen:
            self = .yemen
            
        case Server.Zambia:
            self = .zambia
            
        case Server.Zimbabwe:
            self = .zimbabwe

        default:
            self = .none
        }
    }

    var stringValue: String {
        switch self {
        case .none:
            return Server.None

        case .afghanistan:
            return Server.Afghanistan

        case .albania:
            return Server.Albania

        case .algeria:
            return Server.Algeria

        case .andorra:
            return Server.Andorra

        case .angola:
            return Server.Angola

        case .antiguaAndBarbuda:
            return Server.AntiguaAndBarbuda

        case .argentina:
            return Server.Argentina

        case .armenia:
            return Server.Armenia

        case .aruba:
            return Server.Aruba

        case .australia:
            return Server.Australia

        case .austria:
            return Server.Austria

        case .azerbaijan:
            return Server.Azerbaijan

        case .bahamas:
            return Server.Bahamas

        case .bahrain:
            return Server.Bahrain

        case .bangladesh:
            return Server.Bangladesh

        case .barbados:
            return Server.Barbados

        case .belarus:
            return Server.Belarus

        case .belgium:
            return Server.Belgium

        case .belize:
            return Server.Belize

        case .benin:
            return Server.Benin

        case .bhutan:
            return Server.Bhutan

        case .bolivia:
            return Server.Bolivia

        case .bosniaAndHerzegovina:
            return Server.BosniaAndHerzegovina

        case .botswana:
            return Server.Botswana

        case .brazil:
            return Server.Brazil

        case .brunei:
            return Server.Brunei

        case .bulgaria:
            return Server.Bulgaria

        case .burkinaFaso:
            return Server.BurkinaFaso

        case .burma:
            return Server.Burma

        case .burundi:
            return Server.Burundi

        case .cambodia:
            return Server.Cambodia

        case .cameroon:
            return Server.Cameroon

        case .canada:
            return Server.Canada

        case .caboVerde:
            return Server.CaboVerde

        case .centralAfricanRepublic:
            return Server.CentralAfricanRepublic

        case .chad:
            return Server.Chad

        case .chile:
            return Server.Chile

        case .china:
            return Server.China

        case .colombia:
            return Server.Colombia

        case .comoros:
            return Server.Comoros

        case .costaRica:
            return Server.CostaRica

        case .cotedIvoire:
            return Server.CotedIvoire

        case .croatia:
            return Server.Croatia

        case .cuba:
            return Server.Cuba

        case .curacao:
            return Server.Curacao

        case .cyprus:
            return Server.Cyprus

        case .czechia:
            return Server.Czechia

        case .democraticRepublicOfTheCongo:
            return Server.DemocraticRepublicOfTheCongo

        case .denmark:
            return Server.Denmark

        case .djibouti:
            return Server.Djibouti

        case .dominica:
            return Server.Dominica

        case .dominicanRepublic:
            return Server.DominicanRepublic

        case .ecuador:
            return Server.Ecuador

        case .egypt:
            return Server.Egypt

        case .elSalvador:
            return Server.ElSalvador

        case .equatorialGuinea:
            return Server.EquatorialGuinea

        case .eritrea:
            return Server.Eritrea

        case .estonia:
            return Server.Estonia

        case .ethiopia:
            return Server.Ethiopia

        case .fiji:
            return Server.Fiji

        case .finland:
            return Server.Finland

        case .france:
            return Server.France

        case .gabon:
            return Server.Gabon

        case .gambia:
            return Server.Gambia

        case .georgia:
            return Server.Georgia

        case .germany:
            return Server.Germany

        case .ghana:
            return Server.Ghana

        case .greece:
            return Server.Greece

        case .grenada:
            return Server.Grenada

        case .guatemala:
            return Server.Guatemala

        case .guinea:
            return Server.Guinea

        case .guineaBissau:
            return Server.GuineaBissau

        case .guyana:
            return Server.Guyana

        case .haiti:
            return Server.Haiti

        case .holySee:
            return Server.HolySee

        case .honduras:
            return Server.Honduras

        case .hongKong:
            return Server.HongKong

        case .hungary:
            return Server.Hungary

        case .iceland:
            return Server.Iceland

        case .india:
            return Server.India

        case .indonesia:
            return Server.Indonesia

        case .iran:
            return Server.Iran

        case .iraq:
            return Server.Iraq

        case .ireland:
            return Server.Ireland

        case .israel:
            return Server.Israel

        case .italy:
            return Server.Italy

        case .jamaica:
            return Server.Jamaica

        case .japan:
            return Server.Japan

        case .jordan:
            return Server.Jordan

        case .kazakhstan:
            return Server.Kazakhstan

        case .kenya:
            return Server.Kenya

        case .kiribati:
            return Server.Kiribati

        case .kosovo:
            return Server.Kosovo

        case .kuwait:
            return Server.Kuwait

        case .kyrgyzstan:
            return Server.Kyrgyzstan

        case .laos:
            return Server.Laos

        case .latvia:
            return Server.Latvia

        case .lebanon:
            return Server.Lebanon

        case .lesotho:
            return Server.Lesotho

        case .liberia:
            return Server.Liberia

        case .libya:
            return Server.Libya

        case .liechtenstein:
            return Server.Liechtenstein

        case .lithuania:
            return Server.Lithuania

        case .luxembourg:
            return Server.Luxembourg

        case .macau:
            return Server.Macau

        case .macedonia:
            return Server.Macedonia

        case .madagascar:
            return Server.Madagascar

        case .malawi:
            return Server.Malawi

        case .malaysia:
            return Server.Malaysia

        case .maldives:
            return Server.Maldives

        case .mali:
            return Server.Mali

        case .malta:
            return Server.Malta

        case .marshallIslands:
            return Server.MarshallIslands

        case .mauritania:
            return Server.Mauritania

        case .mauritius:
            return Server.Mauritius

        case .mexico:
            return Server.Mexico

        case .micronesia:
            return Server.Micronesia

        case .moldova:
            return Server.Moldova

        case .monaco:
            return Server.Monaco

        case .mongolia:
            return Server.Mongolia

        case .montenegro:
            return Server.Montenegro

        case .morocco:
            return Server.Morocco

        case .mozambique:
            return Server.Mozambique

        case .namibia:
            return Server.Namibia

        case .nauru:
            return Server.Nauru

        case .nepal:
            return Server.Nepal

        case .netherlands:
            return Server.Netherlands

        case .newZealand:
            return Server.NewZealand

        case .nicaragua:
            return Server.Nicaragua

        case .niger:
            return Server.Niger

        case .nigeria:
            return Server.Nigeria

        case .northKorea:
            return Server.NorthKorea

        case .norway:
            return Server.Norway

        case .oman:
            return Server.Oman

        case .pakistan:
            return Server.Pakistan

        case .palau:
            return Server.Palau

        case .palestinianTerritories:
            return Server.PalestinianTerritories

        case .panama:
            return Server.Panama

        case .papuaNewGuinea:
            return Server.PapuaNewGuinea

        case .paraguay:
            return Server.Paraguay

        case .peru:
            return Server.Peru

        case .philippines:
            return Server.Philippines

        case .poland:
            return Server.Poland

        case .portugal:
            return Server.Portugal

        case .qatar:
            return Server.Qatar

        case .republicOfTheCongo:
            return Server.RepublicOfTheCongo

        case .romania:
            return Server.Romania

        case .russia:
            return Server.Russia

        case .rwanda:
            return Server.Rwanda

        case .saintKittsAndNevis:
            return Server.SaintKittsAndNevis

        case .saintLucia:
            return Server.SaintLucia

        case .saintVincentAndTheGrenadines:
            return Server.SaintVincentAndTheGrenadines

        case .samoa:
            return Server.Samoa

        case .sanMarino:
            return Server.SanMarino

        case .saoTomeAndPrincipe:
            return Server.SaoTomeAndPrincipe

        case .saudiArabia:
            return Server.SaudiArabia

        case .senegal:
            return Server.Senegal

        case .serbia:
            return Server.Serbia

        case .seychelles:
            return Server.Seychelles

        case .sierraLeone:
            return Server.SierraLeone

        case .singapore:
            return Server.Singapore

        case .sintMaarten:
            return Server.SintMaarten

        case .slovakia:
            return Server.Slovakia

        case .slovenia:
            return Server.Slovenia

        case .solomonIslands:
            return Server.SolomonIslands

        case .somalia:
            return Server.Somalia

        case .southAfrica:
            return Server.SouthAfrica

        case .southKorea:
            return Server.SouthKorea

        case .southSudan:
            return Server.SouthSudan

        case .spain:
            return Server.Spain

        case .sriLanka:
            return Server.SriLanka

        case .sudan:
            return Server.Sudan

        case .suriname:
            return Server.Suriname

        case .swaziland:
            return Server.Swaziland

        case .sweden:
            return Server.Sweden

        case .switzerland:
            return Server.Switzerland

        case .syria:
            return Server.Syria
            
        case .taiwan:
            return Server.Taiwan
            
        case .tajikistan:
            return Server.Tajikistan
            
        case .tanzania:
            return Server.Tanzania
            
        case .thailand:
            return Server.Thailand
            
        case .timorLeste:
            return Server.TimorLeste
            
        case .togo:
            return Server.Togo
            
        case .tonga:
            return Server.Tonga
            
        case .trinidadAndTobago:
            return Server.TrinidadAndTobago
            
        case .tunisia:
            return Server.Tunisia
            
        case .turkey:
            return Server.Turkey
            
        case .turkmenistan:
            return Server.Turkmenistan
            
        case .tuvalu:
            return Server.Tuvalu
            
        case .uganda:
            return Server.Uganda
            
        case .ukraine:
            return Server.Ukraine
            
        case .unitedArabEmirates:
            return Server.UnitedArabEmirates
            
        case .unitedKingdom:
            return Server.UnitedKingdom
            
        case .unitedStatesOfAmerica:
            return Server.UnitedStatesOfAmerica
            
        case .uruguay:
            return Server.Uruguay
            
        case .uzbekistan:
            return Server.Uzbekistan
            
        case .vanuatu:
            return Server.Vanuatu
            
        case .venezuela:
            return Server.Venezuela
            
        case .vietnam:
            return Server.Vietnam
            
        case .yemen:
            return Server.Yemen
            
        case .zambia:
            return Server.Zambia
            
        case .zimbabwe:
            return Server.Zimbabwe
        }
    }

}

extension LanguageName {

    private typealias Server = String.Server.LanguageName

    init(stringValue: String) {
        switch stringValue {
        case Server.Afrikaans:
            self = .afrikaans

        case Server.Albanian:
            self = .albanian

        case Server.Amharic:
            self = .amharic

        case Server.Arabic:
            self = .arabic

        case Server.Aramaic:
            self = .aramaic

        case Server.Armenian:
            self = .armenian

        case Server.Assamese:
            self = .assamese

        case Server.Aymara:
            self = .aymara

        case Server.Azerbaijani:
            self = .azerbaijani

        case Server.Balochi:
            self = .balochi

        case Server.Bamanankan:
            self = .bamanankan

        case Server.Bashkir:
            self = .bashkir

        case Server.Basque:
            self = .basque

        case Server.Belarusian:
            self = .belarusian

        case Server.Bengali:
            self = .bengali

        case Server.Bhojpuri:
            self = .bhojpuri

        case Server.Bislama:
            self = .bislama

        case Server.Bosnian:
            self = .bosnian

        case Server.Brahui:
            self = .brahui

        case Server.Bulgarian:
            self = .bulgarian

        case Server.Burmese:
            self = .burmese

        case Server.Cantonese:
            self = .cantonese

        case Server.Catalan:
            self = .catalan

        case Server.Cebuano:
            self = .cebuano

        case Server.Chechen:
            self = .chechen

        case Server.Cherokee:
            self = .cherokee

        case Server.Croatian:
            self = .croatian

        case Server.Czech:
            self = .czech

        case Server.Dakota:
            self = .dakota

        case Server.Danish:
            self = .danish

        case Server.Dari:
            self = .dari

        case Server.Dholuo:
            self = .dholuo

        case Server.Dutch:
            self = .dutch

        case Server.English:
            self = .english

        case Server.Esperanto:
            self = .esperanto

        case Server.Estonian:
            self = .estonian

        case Server.Ewe:
            self = .ewe

        case Server.Finnish:
            self = .finnish

        case Server.French:
            self = .french

        case Server.Georgian:
            self = .georgian

        case Server.German:
            self = .german

        case Server.Gikuyu:
            self = .gikuyu

        case Server.Greek:
            self = .greek

        case Server.Guarani:
            self = .guarani

        case Server.Gujarati:
            self = .gujarati

        case Server.HaitianCreole:
            self = .haitianCreole

        case Server.Hausa:
            self = .hausa

        case Server.Hawaiian:
            self = .hawaiian

        case Server.Hebrew:
            self = .hebrew

        case Server.Hiligaynon:
            self = .hiligaynon

        case Server.Hindi:
            self = .hindi

        case Server.Hungarian:
            self = .hungarian

        case Server.Icelandic:
            self = .icelandic

        case Server.Igbo:
            self = .igbo

        case Server.Ilocano:
            self = .ilocano

        case Server.Indonesian:
            self = .indonesian

        case Server.Inuit:
            self = .inuit

        case Server.IrishGaelic:
            self = .irishGaelic

        case Server.Italian:
            self = .italian

        case Server.Japanese:
            self = .japanese

        case Server.Jarai:
            self = .jarai

        case Server.Javanese:
            self = .javanese

        case Server.Kiche:
            self = .kiche

        case Server.Kabyle:
            self = .kabyle

        case Server.Kannada:
            self = .kannada

        case Server.Kashmiri:
            self = .kashmiri

        case Server.Kazakh:
            self = .kazakh

        case Server.Khmer:
            self = .khmer

        case Server.Khoekhoe:
            self = .khoekhoe

        case Server.Korean:
            self = .korean

        case Server.Kurdish:
            self = .kurdish

        case Server.Kyrgyz:
            self = .kyrgyz

        case Server.Lao:
            self = .lao

        case Server.Latin:
            self = .latin

        case Server.Latvian:
            self = .latvian

        case Server.Lingala:
            self = .lingala

        case Server.Lithuanian:
            self = .lithuanian

        case Server.Macedonian:
            self = .macedonian

        case Server.Maithili:
            self = .maithili

        case Server.Malagasy:
            self = .malagasy

        case Server.Malay:
            self = .malay

        case Server.Malayalam:
            self = .malayalam

        case Server.Mandarin:
            self = .mandarin

        case Server.Marathi:
            self = .marathi

        case Server.Mende:
            self = .mende

        case Server.Mongolian:
            self = .mongolian

        case Server.Nahuatl:
            self = .nahuatl

        case Server.Navajo:
            self = .navajo

        case Server.Nepali:
            self = .nepali

        case Server.Norwegian:
            self = .norwegian

        case Server.Ojibwa:
            self = .ojibwa

        case Server.Oriya:
            self = .oriya

        case Server.Oromo:
            self = .oromo

        case Server.Pashto:
            self = .pashto

        case Server.Persian:
            self = .persian

        case Server.Polish:
            self = .polish

        case Server.Portuguese:
            self = .portuguese

        case Server.Punjabi:
            self = .punjabi

        case Server.Quechua:
            self = .quechua

        case Server.Romani:
            self = .romani

        case Server.Romanian:
            self = .romanian

        case Server.Russian:
            self = .russian

        case Server.Rwanda:
            self = .rwanda

        case Server.Samoan:
            self = .samoan

        case Server.Sanskrit:
            self = .sanskrit

        case Server.Serbian:
            self = .serbian

        case Server.Shona:
            self = .shona

        case Server.Sindhi:
            self = .sindhi

        case Server.Sinhala:
            self = .sinhala

        case Server.Slovak:
            self = .slovak

        case Server.Slovene:
            self = .slovene

        case Server.Somali:
            self = .somali

        case Server.Spanish:
            self = .spanish

        case Server.Swahili:
            self = .swahili

        case Server.Swedish:
            self = .swedish

        case Server.Tachelhit:
            self = .tachelhit

        case Server.Tagalog:
            self = .tagalog

        case Server.Tajiki:
            self = .tajiki

        case Server.Tamil:
            self = .tamil

        case Server.Tatar:
            self = .tatar

        case Server.Telugu:
            self = .telugu

        case Server.Thai:
            self = .thai

        case Server.Tigrigna:
            self = .tigrigna

        case Server.TokPisin:
            self = .tokPisin

        case Server.Turkish:
            self = .turkish

        case Server.Turkmen:
            self = .turkmen

        case Server.Ukrainian:
            self = .ukrainian

        case Server.Urdu:
            self = .urdu

        case Server.Uyghur:
            self = .uyghur

        case Server.Uzbek:
            self = .uzbek

        case Server.Vietnamese:
            self = .vietnamese

        case Server.Warlpiri:
            self = .warlpiri

        case Server.Welsh:
            self = .welsh

        case Server.Wolof:
            self = .wolof

        case Server.Xhosa:
            self = .xhosa

        case Server.Yakut:
            self = .yakut

        case Server.Yiddish:
            self = .yiddish

        case Server.Yoruba:
            self = .yoruba

        case Server.Yucatec:
            self = .yucatec

        case Server.Zapotec:
            self = .zapotec

        case Server.Zulu:
            self = .zulu

        default:
            self = .none
        }
    }

    var stringValue: String {
        switch self {
        case .none:
            return Server.None

        case .afrikaans:
            return Server.Afrikaans

        case .albanian:
            return Server.Albanian

        case .amharic:
            return Server.Amharic

        case .arabic:
            return Server.Arabic

        case .aramaic:
            return Server.Aramaic

        case .armenian:
            return Server.Armenian

        case .assamese:
            return Server.Assamese

        case .aymara:
            return Server.Aymara

        case .azerbaijani:
            return Server.Azerbaijani

        case .balochi:
            return Server.Balochi

        case .bamanankan:
            return Server.Bamanankan

        case .bashkir:
            return Server.Bashkir

        case .basque:
            return Server.Basque

        case .belarusian:
            return Server.Belarusian

        case .bengali:
            return Server.Bengali

        case .bhojpuri:
            return Server.Bhojpuri

        case .bislama:
            return Server.Bislama

        case .bosnian:
            return Server.Bosnian

        case .brahui:
            return Server.Brahui

        case .bulgarian:
            return Server.Bulgarian

        case .burmese:
            return Server.Burmese

        case .cantonese:
            return Server.Cantonese

        case .catalan:
            return Server.Catalan

        case .cebuano:
            return Server.Cebuano

        case .chechen:
            return Server.Chechen

        case .cherokee:
            return Server.Cherokee

        case .croatian:
            return Server.Croatian

        case .czech:
            return Server.Czech

        case .dakota:
            return Server.Dakota

        case .danish:
            return Server.Danish

        case .dari:
            return Server.Dari

        case .dholuo:
            return Server.Dholuo

        case .dutch:
            return Server.Dutch

        case .english:
            return Server.English

        case .esperanto:
            return Server.Esperanto

        case .estonian:
            return Server.Estonian

        case .ewe:
            return Server.Ewe

        case .finnish:
            return Server.Finnish

        case .french:
            return Server.French

        case .georgian:
            return Server.Georgian

        case .german:
            return Server.German

        case .gikuyu:
            return Server.Gikuyu

        case .greek:
            return Server.Greek

        case .guarani:
            return Server.Guarani

        case .gujarati:
            return Server.Gujarati

        case .haitianCreole:
            return Server.HaitianCreole

        case .hausa:
            return Server.Hausa

        case .hawaiian:
            return Server.Hawaiian

        case .hebrew:
            return Server.Hebrew

        case .hiligaynon:
            return Server.Hiligaynon

        case .hindi:
            return Server.Hindi

        case .hungarian:
            return Server.Hungarian

        case .icelandic:
            return Server.Icelandic

        case .igbo:
            return Server.Igbo

        case .ilocano:
            return Server.Ilocano

        case .indonesian:
            return Server.Indonesian

        case .inuit:
            return Server.Inuit

        case .irishGaelic:
            return Server.IrishGaelic

        case .italian:
            return Server.Italian

        case .japanese:
            return Server.Japanese

        case .jarai:
            return Server.Jarai

        case .javanese:
            return Server.Javanese

        case .kiche:
            return Server.Kiche

        case .kabyle:
            return Server.Kabyle

        case .kannada:
            return Server.Kannada

        case .kashmiri:
            return Server.Kashmiri

        case .kazakh:
            return Server.Kazakh

        case .khmer:
            return Server.Khmer

        case .khoekhoe:
            return Server.Khoekhoe

        case .korean:
            return Server.Korean

        case .kurdish:
            return Server.Kurdish

        case .kyrgyz:
            return Server.Kyrgyz

        case .lao:
            return Server.Lao

        case .latin:
            return Server.Latin

        case .latvian:
            return Server.Latvian

        case .lingala:
            return Server.Lingala

        case .lithuanian:
            return Server.Lithuanian

        case .macedonian:
            return Server.Macedonian

        case .maithili:
            return Server.Maithili

        case .malagasy:
            return Server.Malagasy

        case .malay:
            return Server.Malay

        case .malayalam:
            return Server.Malayalam

        case .mandarin:
            return Server.Mandarin

        case .marathi:
            return Server.Marathi

        case .mende:
            return Server.Mende

        case .mongolian:
            return Server.Mongolian

        case .nahuatl:
            return Server.Nahuatl

        case .navajo:
            return Server.Navajo

        case .nepali:
            return Server.Nepali

        case .norwegian:
            return Server.Norwegian

        case .ojibwa:
            return Server.Ojibwa

        case .oriya:
            return Server.Oriya

        case .oromo:
            return Server.Oromo

        case .pashto:
            return Server.Pashto

        case .persian:
            return Server.Persian

        case .polish:
            return Server.Polish

        case .portuguese:
            return Server.Portuguese

        case .punjabi:
            return Server.Punjabi

        case .quechua:
            return Server.Quechua

        case .romani:
            return Server.Romani

        case .romanian:
            return Server.Romanian

        case .russian:
            return Server.Russian

        case .rwanda:
            return Server.Rwanda

        case .samoan:
            return Server.Samoan

        case .sanskrit:
            return Server.Sanskrit

        case .serbian:
            return Server.Serbian

        case .shona:
            return Server.Shona

        case .sindhi:
            return Server.Sindhi

        case .sinhala:
            return Server.Sinhala

        case .slovak:
            return Server.Slovak

        case .slovene:
            return Server.Slovene

        case .somali:
            return Server.Somali

        case .spanish:
            return Server.Spanish

        case .swahili:
            return Server.Swahili

        case .swedish:
            return Server.Swedish

        case .tachelhit:
            return Server.Tachelhit

        case .tagalog:
            return Server.Tagalog

        case .tajiki:
            return Server.Tajiki

        case .tamil:
            return Server.Tamil

        case .tatar:
            return Server.Tatar

        case .telugu:
            return Server.Telugu

        case .thai:
            return Server.Thai

        case .tigrigna:
            return Server.Tigrigna
            
        case .tokPisin:
            return Server.TokPisin
            
        case .turkish:
            return Server.Turkish
            
        case .turkmen:
            return Server.Turkmen
            
        case .ukrainian:
            return Server.Ukrainian
            
        case .urdu:
            return Server.Urdu
            
        case .uyghur:
            return Server.Uyghur
            
        case .uzbek:
            return Server.Uzbek
            
        case .vietnamese:
            return Server.Vietnamese
            
        case .warlpiri:
            return Server.Warlpiri
            
        case .welsh:
            return Server.Welsh
            
        case .wolof:
            return Server.Wolof
            
        case .xhosa:
            return Server.Xhosa
            
        case .yakut:
            return Server.Yakut
            
        case .yiddish:
            return Server.Yiddish
            
        case .yoruba:
            return Server.Yoruba
            
        case .yucatec:
            return Server.Yucatec
            
        case .zapotec:
            return Server.Zapotec
            
        case .zulu:
            return Server.Zulu
        }
    }

}

extension LanguageLevel {

    private typealias Server = String.Server.LanguageLevel

    init(stringValue: String) {
        switch stringValue {
        case Server.Beginner:
            self = .beginner

        case Server.Intermediate:
            self = .intermediate

        case Server.Advanced:
            self = .advanced

        case Server.Fluent:
            self = .fluent

        case Server.Native:
            self = .native

        default:
            self = .none
        }
    }

    var stringValue: String {
        switch self {
        case .none:
            return Server.None

        case .beginner:
            return Server.Beginner

        case .intermediate:
            return Server.Intermediate

        case .advanced:
            return Server.Advanced

        case .fluent:
            return Server.Fluent

        case .native:
            return Server.Native
        }
    }
    
}

extension MessageType {

    private typealias Server = String.Server.MessageType

    init?(stringValue: String) {
        switch stringValue {
        case Server.plain:
            self = .plain

        case Server.comment:
            self = .comment

        default:
            return nil
        }
    }

    var stringValue: String {
        switch self {
        case .plain:
            return Server.plain

        case .comment:
            return Server.comment
        }
    }

}

extension MessageDataType {

    private typealias Server = String.Server.MessageDataType

    init?(stringValue: String) {
        switch stringValue {
        case Server.text:
            self = .text

        case Server.image:
            self = .image

        case Server.audio:
            self = .audio

        default:
            return nil
        }
    }

    var stringValue: String {
        switch self {
        case .text:
            return Server.text

        case .image:
            return Server.image

        case .audio:
            return Server.audio
        }
    }
    
}
