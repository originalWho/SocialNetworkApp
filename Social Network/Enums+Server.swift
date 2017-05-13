import Foundation

extension Gender {

    private typealias Server = String.Server.Gender

    init(stringValue: String) {
        switch stringValue {
        case Server.Male:
            self = .Male

        case Server.Female:
            self = .Female

        default:
            self = .None
        }
    }

    var stringValue: String {
        switch self {
        case .None:
            return Server.None

        case .Male:
            return Server.Male

        case .Female:
            return Server.Female
        }
    }

}

extension Country {

    private typealias Server = String.Server.Country

    init(stringValue: String) {
        switch stringValue {
        case Server.Afghanistan:
            self = .Afghanistan

        case Server.Albania:
            self = .Albania

        case Server.Algeria:
            self = .Algeria

        case Server.Andorra:
            self = .Andorra

        case Server.Angola:
            self = .Angola

        case Server.AntiguaAndBarbuda:
            self = .AntiguaAndBarbuda

        case Server.Argentina:
            self = .Argentina

        case Server.Armenia:
            self = .Armenia

        case Server.Aruba:
            self = .Aruba

        case Server.Australia:
            self = .Australia

        case Server.Austria:
            self = .Austria

        case Server.Azerbaijan:
            self = .Azerbaijan

        case Server.Bahamas:
            self = .Bahamas

        case Server.Bahrain:
            self = .Bahrain

        case Server.Bangladesh:
            self = .Bangladesh

        case Server.Barbados:
            self = .Barbados

        case Server.Belarus:
            self = .Belarus

        case Server.Belgium:
            self = .Belgium

        case Server.Belize:
            self = .Belize

        case Server.Benin:
            self = .Benin

        case Server.Bhutan:
            self = .Bhutan

        case Server.Bolivia:
            self = .Bolivia

        case Server.BosniaAndHerzegovina:
            self = .BosniaAndHerzegovina

        case Server.Botswana:
            self = .Botswana

        case Server.Brazil:
            self = .Brazil

        case Server.Brunei:
            self = .Brunei

        case Server.Bulgaria:
            self = .Bulgaria

        case Server.BurkinaFaso:
            self = .BurkinaFaso

        case Server.Burma:
            self = .Burma

        case Server.Burundi:
            self = .Burundi

        case Server.Cambodia:
            self = .Cambodia

        case Server.Cameroon:
            self = .Cameroon

        case Server.Canada:
            self = .Canada

        case Server.CaboVerde:
            self = .CaboVerde

        case Server.CentralAfricanRepublic:
            self = .CentralAfricanRepublic

        case Server.Chad:
            self = .Chad

        case Server.Chile:
            self = .Chile

        case Server.China:
            self = .China

        case Server.Colombia:
            self = .Colombia

        case Server.Comoros:
            self = .Comoros

        case Server.CostaRica:
            self = .CostaRica

        case Server.CotedIvoire:
            self = .CotedIvoire

        case Server.Croatia:
            self = .Croatia

        case Server.Cuba:
            self = .Cuba

        case Server.Curacao:
            self = .Curacao

        case Server.Cyprus:
            self = .Cyprus

        case Server.Czechia:
            self = .Czechia

        case Server.DemocraticRepublicOfTheCongo:
            self = .DemocraticRepublicOfTheCongo

        case Server.Denmark:
            self = .Denmark

        case Server.Djibouti:
            self = .Djibouti

        case Server.Dominica:
            self = .Dominica

        case Server.DominicanRepublic:
            self = .DominicanRepublic

        case Server.Ecuador:
            self = .Ecuador

        case Server.Egypt:
            self = .Egypt

        case Server.ElSalvador:
            self = .ElSalvador

        case Server.EquatorialGuinea:
            self = .EquatorialGuinea

        case Server.Eritrea:
            self = .Eritrea

        case Server.Estonia:
            self = .Estonia

        case Server.Ethiopia:
            self = .Ethiopia

        case Server.Fiji:
            self = .Fiji

        case Server.Finland:
            self = .Finland

        case Server.France:
            self = .France

        case Server.Gabon:
            self = .Gabon

        case Server.Gambia:
            self = .Gambia

        case Server.Georgia:
            self = .Georgia

        case Server.Germany:
            self = .Germany

        case Server.Ghana:
            self = .Ghana

        case Server.Greece:
            self = .Greece

        case Server.Grenada:
            self = .Grenada

        case Server.Guatemala:
            self = .Guatemala

        case Server.Guinea:
            self = .Guinea

        case Server.GuineaBissau:
            self = .GuineaBissau

        case Server.Guyana:
            self = .Guyana

        case Server.Haiti:
            self = .Haiti

        case Server.HolySee:
            self = .HolySee

        case Server.Honduras:
            self = .Honduras

        case Server.HongKong:
            self = .HongKong

        case Server.Hungary:
            self = .Hungary

        case Server.Iceland:
            self = .Iceland

        case Server.India:
            self = .India

        case Server.Indonesia:
            self = .Indonesia

        case Server.Iran:
            self = .Iran

        case Server.Iraq:
            self = .Iraq

        case Server.Ireland:
            self = .Ireland

        case Server.Israel:
            self = .Israel

        case Server.Italy:
            self = .Italy

        case Server.Jamaica:
            self = .Jamaica

        case Server.Japan:
            self = .Japan

        case Server.Jordan:
            self = .Jordan

        case Server.Kazakhstan:
            self = .Kazakhstan

        case Server.Kenya:
            self = .Kenya

        case Server.Kiribati:
            self = .Kiribati

        case Server.Kosovo:
            self = .Kosovo

        case Server.Kuwait:
            self = .Kuwait

        case Server.Kyrgyzstan:
            self = .Kyrgyzstan

        case Server.Laos:
            self = .Laos

        case Server.Latvia:
            self = .Latvia

        case Server.Lebanon:
            self = .Lebanon

        case Server.Lesotho:
            self = .Lesotho

        case Server.Liberia:
            self = .Liberia

        case Server.Libya:
            self = .Libya

        case Server.Liechtenstein:
            self = .Liechtenstein

        case Server.Lithuania:
            self = .Lithuania

        case Server.Luxembourg:
            self = .Luxembourg

        case Server.Macau:
            self = .Macau

        case Server.Macedonia:
            self = .Macedonia

        case Server.Madagascar:
            self = .Madagascar

        case Server.Malawi:
            self = .Malawi

        case Server.Malaysia:
            self = .Malaysia

        case Server.Maldives:
            self = .Maldives

        case Server.Mali:
            self = .Mali

        case Server.Malta:
            self = .Malta

        case Server.MarshallIslands:
            self = .MarshallIslands

        case Server.Mauritania:
            self = .Mauritania

        case Server.Mauritius:
            self = .Mauritius

        case Server.Mexico:
            self = .Mexico

        case Server.Micronesia:
            self = .Micronesia

        case Server.Moldova:
            self = .Moldova

        case Server.Monaco:
            self = .Monaco

        case Server.Mongolia:
            self = .Mongolia

        case Server.Montenegro:
            self = .Montenegro

        case Server.Morocco:
            self = .Morocco

        case Server.Mozambique:
            self = .Mozambique

        case Server.Namibia:
            self = .Namibia

        case Server.Nauru:
            self = .Nauru

        case Server.Nepal:
            self = .Nepal

        case Server.Netherlands:
            self = .Netherlands

        case Server.NewZealand:
            self = .NewZealand

        case Server.Nicaragua:
            self = .Nicaragua

        case Server.Niger:
            self = .Niger

        case Server.Nigeria:
            self = .Nigeria

        case Server.NorthKorea:
            self = .NorthKorea

        case Server.Norway:
            self = .Norway

        case Server.Oman:
            self = .Oman

        case Server.Pakistan:
            self = .Pakistan

        case Server.Palau:
            self = .Palau

        case Server.PalestinianTerritories:
            self = .PalestinianTerritories

        case Server.Panama:
            self = .Panama

        case Server.PapuaNewGuinea:
            self = .PapuaNewGuinea

        case Server.Paraguay:
            self = .Paraguay

        case Server.Peru:
            self = .Peru

        case Server.Philippines:
            self = .Philippines

        case Server.Poland:
            self = .Poland

        case Server.Portugal:
            self = .Portugal

        case Server.Qatar:
            self = .Qatar

        case Server.RepublicOfTheCongo:
            self = .RepublicOfTheCongo

        case Server.Romania:
            self = .Romania

        case Server.Russia:
            self = .Russia

        case Server.Rwanda:
            self = .Rwanda

        case Server.SaintKittsAndNevis:
            self = .SaintKittsAndNevis

        case Server.SaintLucia:
            self = .SaintLucia

        case Server.SaintVincentAndTheGrenadines:
            self = .SaintVincentAndTheGrenadines

        case Server.Samoa:
            self = .Samoa

        case Server.SanMarino:
            self = .SanMarino

        case Server.SaoTomeAndPrincipe:
            self = .SaoTomeAndPrincipe

        case Server.SaudiArabia:
            self = .SaudiArabia

        case Server.Senegal:
            self = .Senegal

        case Server.Serbia:
            self = .Serbia

        case Server.Seychelles:
            self = .Seychelles

        case Server.SierraLeone:
            self = .SierraLeone

        case Server.Singapore:
            self = .Singapore

        case Server.SintMaarten:
            self = .SintMaarten

        case Server.Slovakia:
            self = .Slovakia

        case Server.Slovenia:
            self = .Slovenia

        case Server.SolomonIslands:
            self = .SolomonIslands

        case Server.Somalia:
            self = .Somalia

        case Server.SouthAfrica:
            self = .SouthAfrica

        case Server.SouthKorea:
            self = .SouthKorea

        case Server.SouthSudan:
            self = .SouthSudan

        case Server.Spain:
            self = .Spain

        case Server.SriLanka:
            self = .SriLanka
            
        case Server.Sudan:
            self = .Sudan
            
        case Server.Suriname:
            self = .Suriname
            
        case Server.Swaziland:
            self = .Swaziland
            
        case Server.Sweden:
            self = .Sweden
            
        case Server.Switzerland:
            self = .Switzerland
            
        case Server.Syria:
            self = .Syria
            
        case Server.Taiwan:
            self = .Taiwan
            
        case Server.Tajikistan:
            self = .Tajikistan
            
        case Server.Tanzania:
            self = .Tanzania
            
        case Server.Thailand:
            self = .Thailand
            
        case Server.TimorLeste:
            self = .TimorLeste
            
        case Server.Togo:
            self = .Togo
            
        case Server.Tonga:
            self = .Tonga
            
        case Server.TrinidadAndTobago:
            self = .TrinidadAndTobago
            
        case Server.Tunisia:
            self = .Tunisia
            
        case Server.Turkey:
            self = .Turkey
            
        case Server.Turkmenistan:
            self = .Turkmenistan
            
        case Server.Tuvalu:
            self = .Tuvalu
            
        case Server.Uganda:
            self = .Uganda
            
        case Server.Ukraine:
            self = .Ukraine
            
        case Server.UnitedArabEmirates:
            self = .UnitedArabEmirates
            
        case Server.UnitedKingdom:
            self = .UnitedKingdom
            
        case Server.UnitedStatesOfAmerica:
            self = .UnitedStatesOfAmerica
            
        case Server.Uruguay:
            self = .Uruguay
            
        case Server.Uzbekistan:
            self = .Uzbekistan
            
        case Server.Vanuatu:
            self = .Vanuatu
            
        case Server.Venezuela:
            self = .Venezuela
            
        case Server.Vietnam:
            self = .Vietnam
            
        case Server.Yemen:
            self = .Yemen
            
        case Server.Zambia:
            self = .Zambia
            
        case Server.Zimbabwe:
            self = .Zimbabwe

        default:
            self = .None
        }
    }

    var stringValue: String {
        switch self {
        case .None:
            return Server.None

        case .Afghanistan:
            return Server.Afghanistan

        case .Albania:
            return Server.Albania

        case .Algeria:
            return Server.Algeria

        case .Andorra:
            return Server.Andorra

        case .Angola:
            return Server.Angola

        case .AntiguaAndBarbuda:
            return Server.AntiguaAndBarbuda

        case .Argentina:
            return Server.Argentina

        case .Armenia:
            return Server.Armenia

        case .Aruba:
            return Server.Aruba

        case .Australia:
            return Server.Australia

        case .Austria:
            return Server.Austria

        case .Azerbaijan:
            return Server.Azerbaijan

        case .Bahamas:
            return Server.Bahamas

        case .Bahrain:
            return Server.Bahrain

        case .Bangladesh:
            return Server.Bangladesh

        case .Barbados:
            return Server.Barbados

        case .Belarus:
            return Server.Belarus

        case .Belgium:
            return Server.Belgium

        case .Belize:
            return Server.Belize

        case .Benin:
            return Server.Benin

        case .Bhutan:
            return Server.Bhutan

        case .Bolivia:
            return Server.Bolivia

        case .BosniaAndHerzegovina:
            return Server.BosniaAndHerzegovina

        case .Botswana:
            return Server.Botswana

        case .Brazil:
            return Server.Brazil

        case .Brunei:
            return Server.Brunei

        case .Bulgaria:
            return Server.Bulgaria

        case .BurkinaFaso:
            return Server.BurkinaFaso

        case .Burma:
            return Server.Burma

        case .Burundi:
            return Server.Burundi

        case .Cambodia:
            return Server.Cambodia

        case .Cameroon:
            return Server.Cameroon

        case .Canada:
            return Server.Canada

        case .CaboVerde:
            return Server.CaboVerde

        case .CentralAfricanRepublic:
            return Server.CentralAfricanRepublic

        case .Chad:
            return Server.Chad

        case .Chile:
            return Server.Chile

        case .China:
            return Server.China

        case .Colombia:
            return Server.Colombia

        case .Comoros:
            return Server.Comoros

        case .CostaRica:
            return Server.CostaRica

        case .CotedIvoire:
            return Server.CotedIvoire

        case .Croatia:
            return Server.Croatia

        case .Cuba:
            return Server.Cuba

        case .Curacao:
            return Server.Curacao

        case .Cyprus:
            return Server.Cyprus

        case .Czechia:
            return Server.Czechia

        case .DemocraticRepublicOfTheCongo:
            return Server.DemocraticRepublicOfTheCongo

        case .Denmark:
            return Server.Denmark

        case .Djibouti:
            return Server.Djibouti

        case .Dominica:
            return Server.Dominica

        case .DominicanRepublic:
            return Server.DominicanRepublic

        case .Ecuador:
            return Server.Ecuador

        case .Egypt:
            return Server.Egypt

        case .ElSalvador:
            return Server.ElSalvador

        case .EquatorialGuinea:
            return Server.EquatorialGuinea

        case .Eritrea:
            return Server.Eritrea

        case .Estonia:
            return Server.Estonia

        case .Ethiopia:
            return Server.Ethiopia

        case .Fiji:
            return Server.Fiji

        case .Finland:
            return Server.Finland

        case .France:
            return Server.France

        case .Gabon:
            return Server.Gabon

        case .Gambia:
            return Server.Gambia

        case .Georgia:
            return Server.Georgia

        case .Germany:
            return Server.Germany

        case .Ghana:
            return Server.Ghana

        case .Greece:
            return Server.Greece

        case .Grenada:
            return Server.Grenada

        case .Guatemala:
            return Server.Guatemala

        case .Guinea:
            return Server.Guinea

        case .GuineaBissau:
            return Server.GuineaBissau

        case .Guyana:
            return Server.Guyana

        case .Haiti:
            return Server.Haiti

        case .HolySee:
            return Server.HolySee

        case .Honduras:
            return Server.Honduras

        case .HongKong:
            return Server.HongKong

        case .Hungary:
            return Server.Hungary

        case .Iceland:
            return Server.Iceland

        case .India:
            return Server.India

        case .Indonesia:
            return Server.Indonesia

        case .Iran:
            return Server.Iran

        case .Iraq:
            return Server.Iraq

        case .Ireland:
            return Server.Ireland

        case .Israel:
            return Server.Israel

        case .Italy:
            return Server.Italy

        case .Jamaica:
            return Server.Jamaica

        case .Japan:
            return Server.Japan

        case .Jordan:
            return Server.Jordan

        case .Kazakhstan:
            return Server.Kazakhstan

        case .Kenya:
            return Server.Kenya

        case .Kiribati:
            return Server.Kiribati

        case .Kosovo:
            return Server.Kosovo

        case .Kuwait:
            return Server.Kuwait

        case .Kyrgyzstan:
            return Server.Kyrgyzstan

        case .Laos:
            return Server.Laos

        case .Latvia:
            return Server.Latvia

        case .Lebanon:
            return Server.Lebanon

        case .Lesotho:
            return Server.Lesotho

        case .Liberia:
            return Server.Liberia

        case .Libya:
            return Server.Libya

        case .Liechtenstein:
            return Server.Liechtenstein

        case .Lithuania:
            return Server.Lithuania

        case .Luxembourg:
            return Server.Luxembourg

        case .Macau:
            return Server.Macau

        case .Macedonia:
            return Server.Macedonia

        case .Madagascar:
            return Server.Madagascar

        case .Malawi:
            return Server.Malawi

        case .Malaysia:
            return Server.Malaysia

        case .Maldives:
            return Server.Maldives

        case .Mali:
            return Server.Mali

        case .Malta:
            return Server.Malta

        case .MarshallIslands:
            return Server.MarshallIslands

        case .Mauritania:
            return Server.Mauritania

        case .Mauritius:
            return Server.Mauritius

        case .Mexico:
            return Server.Mexico

        case .Micronesia:
            return Server.Micronesia

        case .Moldova:
            return Server.Moldova

        case .Monaco:
            return Server.Monaco

        case .Mongolia:
            return Server.Mongolia

        case .Montenegro:
            return Server.Montenegro

        case .Morocco:
            return Server.Morocco

        case .Mozambique:
            return Server.Mozambique

        case .Namibia:
            return Server.Namibia

        case .Nauru:
            return Server.Nauru

        case .Nepal:
            return Server.Nepal

        case .Netherlands:
            return Server.Netherlands

        case .NewZealand:
            return Server.NewZealand

        case .Nicaragua:
            return Server.Nicaragua

        case .Niger:
            return Server.Niger

        case .Nigeria:
            return Server.Nigeria

        case .NorthKorea:
            return Server.NorthKorea

        case .Norway:
            return Server.Norway

        case .Oman:
            return Server.Oman

        case .Pakistan:
            return Server.Pakistan

        case .Palau:
            return Server.Palau

        case .PalestinianTerritories:
            return Server.PalestinianTerritories

        case .Panama:
            return Server.Panama

        case .PapuaNewGuinea:
            return Server.PapuaNewGuinea

        case .Paraguay:
            return Server.Paraguay

        case .Peru:
            return Server.Peru

        case .Philippines:
            return Server.Philippines

        case .Poland:
            return Server.Poland

        case .Portugal:
            return Server.Portugal

        case .Qatar:
            return Server.Qatar

        case .RepublicOfTheCongo:
            return Server.RepublicOfTheCongo

        case .Romania:
            return Server.Romania

        case .Russia:
            return Server.Russia

        case .Rwanda:
            return Server.Rwanda

        case .SaintKittsAndNevis:
            return Server.SaintKittsAndNevis

        case .SaintLucia:
            return Server.SaintLucia

        case .SaintVincentAndTheGrenadines:
            return Server.SaintVincentAndTheGrenadines

        case .Samoa:
            return Server.Samoa

        case .SanMarino:
            return Server.SanMarino

        case .SaoTomeAndPrincipe:
            return Server.SaoTomeAndPrincipe

        case .SaudiArabia:
            return Server.SaudiArabia

        case .Senegal:
            return Server.Senegal

        case .Serbia:
            return Server.Serbia

        case .Seychelles:
            return Server.Seychelles

        case .SierraLeone:
            return Server.SierraLeone

        case .Singapore:
            return Server.Singapore

        case .SintMaarten:
            return Server.SintMaarten

        case .Slovakia:
            return Server.Slovakia

        case .Slovenia:
            return Server.Slovenia

        case .SolomonIslands:
            return Server.SolomonIslands

        case .Somalia:
            return Server.Somalia

        case .SouthAfrica:
            return Server.SouthAfrica

        case .SouthKorea:
            return Server.SouthKorea

        case .SouthSudan:
            return Server.SouthSudan

        case .Spain:
            return Server.Spain

        case .SriLanka:
            return Server.SriLanka

        case .Sudan:
            return Server.Sudan

        case .Suriname:
            return Server.Suriname

        case .Swaziland:
            return Server.Swaziland

        case .Sweden:
            return Server.Sweden

        case .Switzerland:
            return Server.Switzerland

        case .Syria:
            return Server.Syria
            
        case .Taiwan:
            return Server.Taiwan
            
        case .Tajikistan:
            return Server.Tajikistan
            
        case .Tanzania:
            return Server.Tanzania
            
        case .Thailand:
            return Server.Thailand
            
        case .TimorLeste:
            return Server.TimorLeste
            
        case .Togo:
            return Server.Togo
            
        case .Tonga:
            return Server.Tonga
            
        case .TrinidadAndTobago:
            return Server.TrinidadAndTobago
            
        case .Tunisia:
            return Server.Tunisia
            
        case .Turkey:
            return Server.Turkey
            
        case .Turkmenistan:
            return Server.Turkmenistan
            
        case .Tuvalu:
            return Server.Tuvalu
            
        case .Uganda:
            return Server.Uganda
            
        case .Ukraine:
            return Server.Ukraine
            
        case .UnitedArabEmirates:
            return Server.UnitedArabEmirates
            
        case .UnitedKingdom:
            return Server.UnitedKingdom
            
        case .UnitedStatesOfAmerica:
            return Server.UnitedStatesOfAmerica
            
        case .Uruguay:
            return Server.Uruguay
            
        case .Uzbekistan:
            return Server.Uzbekistan
            
        case .Vanuatu:
            return Server.Vanuatu
            
        case .Venezuela:
            return Server.Venezuela
            
        case .Vietnam:
            return Server.Vietnam
            
        case .Yemen:
            return Server.Yemen
            
        case .Zambia:
            return Server.Zambia
            
        case .Zimbabwe:
            return Server.Zimbabwe
        }
    }

}

extension LanguageName {

    private typealias Server = String.Server.LanguageName

    init(stringValue: String) {
        switch stringValue {
        case Server.Afrikaans:
            self = .Afrikaans

        case Server.Albanian:
            self = .Albanian

        case Server.Amharic:
            self = .Amharic

        case Server.Arabic:
            self = .Arabic

        case Server.Aramaic:
            self = .Aramaic

        case Server.Armenian:
            self = .Armenian

        case Server.Assamese:
            self = .Assamese

        case Server.Aymara:
            self = .Aymara

        case Server.Azerbaijani:
            self = .Azerbaijani

        case Server.Balochi:
            self = .Balochi

        case Server.Bamanankan:
            self = .Bamanankan

        case Server.Bashkir:
            self = .Bashkir

        case Server.Basque:
            self = .Basque

        case Server.Belarusian:
            self = .Belarusian

        case Server.Bengali:
            self = .Bengali

        case Server.Bhojpuri:
            self = .Bhojpuri

        case Server.Bislama:
            self = .Bislama

        case Server.Bosnian:
            self = .Bosnian

        case Server.Brahui:
            self = .Brahui

        case Server.Bulgarian:
            self = .Bulgarian

        case Server.Burmese:
            self = .Burmese

        case Server.Cantonese:
            self = .Cantonese

        case Server.Catalan:
            self = .Catalan

        case Server.Cebuano:
            self = .Cebuano

        case Server.Chechen:
            self = .Chechen

        case Server.Cherokee:
            self = .Cherokee

        case Server.Croatian:
            self = .Croatian

        case Server.Czech:
            self = .Czech

        case Server.Dakota:
            self = .Dakota

        case Server.Danish:
            self = .Danish

        case Server.Dari:
            self = .Dari

        case Server.Dholuo:
            self = .Dholuo

        case Server.Dutch:
            self = .Dutch

        case Server.English:
            self = .English

        case Server.Esperanto:
            self = .Esperanto

        case Server.Estonian:
            self = .Estonian

        case Server.Ewe:
            self = .Ewe

        case Server.Finnish:
            self = .Finnish

        case Server.French:
            self = .French

        case Server.Georgian:
            self = .Georgian

        case Server.German:
            self = .German

        case Server.Gikuyu:
            self = .Gikuyu

        case Server.Greek:
            self = .Greek

        case Server.Guarani:
            self = .Guarani

        case Server.Gujarati:
            self = .Gujarati

        case Server.HaitianCreole:
            self = .HaitianCreole

        case Server.Hausa:
            self = .Hausa

        case Server.Hawaiian:
            self = .Hawaiian

        case Server.Hebrew:
            self = .Hebrew

        case Server.Hiligaynon:
            self = .Hiligaynon

        case Server.Hindi:
            self = .Hindi

        case Server.Hungarian:
            self = .Hungarian

        case Server.Icelandic:
            self = .Icelandic

        case Server.Igbo:
            self = .Igbo

        case Server.Ilocano:
            self = .Ilocano

        case Server.Indonesian:
            self = .Indonesian

        case Server.Inuit:
            self = .Inuit

        case Server.IrishGaelic:
            self = .IrishGaelic

        case Server.Italian:
            self = .Italian

        case Server.Japanese:
            self = .Japanese

        case Server.Jarai:
            self = .Jarai

        case Server.Javanese:
            self = .Javanese

        case Server.Kiche:
            self = .Kiche

        case Server.Kabyle:
            self = .Kabyle

        case Server.Kannada:
            self = .Kannada

        case Server.Kashmiri:
            self = .Kashmiri

        case Server.Kazakh:
            self = .Kazakh

        case Server.Khmer:
            self = .Khmer

        case Server.Khoekhoe:
            self = .Khoekhoe

        case Server.Korean:
            self = .Korean

        case Server.Kurdish:
            self = .Kurdish

        case Server.Kyrgyz:
            self = .Kyrgyz

        case Server.Lao:
            self = .Lao

        case Server.Latin:
            self = .Latin

        case Server.Latvian:
            self = .Latvian

        case Server.Lingala:
            self = .Lingala

        case Server.Lithuanian:
            self = .Lithuanian

        case Server.Macedonian:
            self = .Macedonian

        case Server.Maithili:
            self = .Maithili

        case Server.Malagasy:
            self = .Malagasy

        case Server.Malay:
            self = .Malay

        case Server.Malayalam:
            self = .Malayalam

        case Server.Mandarin:
            self = .Mandarin

        case Server.Marathi:
            self = .Marathi

        case Server.Mende:
            self = .Mende

        case Server.Mongolian:
            self = .Mongolian

        case Server.Nahuatl:
            self = .Nahuatl

        case Server.Navajo:
            self = .Navajo

        case Server.Nepali:
            self = .Nepali

        case Server.Norwegian:
            self = .Norwegian

        case Server.Ojibwa:
            self = .Ojibwa

        case Server.Oriya:
            self = .Oriya

        case Server.Oromo:
            self = .Oromo

        case Server.Pashto:
            self = .Pashto

        case Server.Persian:
            self = .Persian

        case Server.Polish:
            self = .Polish

        case Server.Portuguese:
            self = .Portuguese

        case Server.Punjabi:
            self = .Punjabi

        case Server.Quechua:
            self = .Quechua

        case Server.Romani:
            self = .Romani

        case Server.Romanian:
            self = .Romanian

        case Server.Russian:
            self = .Russian

        case Server.Rwanda:
            self = .Rwanda

        case Server.Samoan:
            self = .Samoan

        case Server.Sanskrit:
            self = .Sanskrit

        case Server.Serbian:
            self = .Serbian

        case Server.Shona:
            self = .Shona

        case Server.Sindhi:
            self = .Sindhi

        case Server.Sinhala:
            self = .Sinhala

        case Server.Slovak:
            self = .Slovak

        case Server.Slovene:
            self = .Slovene

        case Server.Somali:
            self = .Somali

        case Server.Spanish:
            self = .Spanish

        case Server.Swahili:
            self = .Swahili

        case Server.Swedish:
            self = .Swedish

        case Server.Tachelhit:
            self = .Tachelhit

        case Server.Tagalog:
            self = .Tagalog

        case Server.Tajiki:
            self = .Tajiki

        case Server.Tamil:
            self = .Tamil

        case Server.Tatar:
            self = .Tatar

        case Server.Telugu:
            self = .Telugu

        case Server.Thai:
            self = .Thai

        case Server.Tigrigna:
            self = .Tigrigna

        case Server.TokPisin:
            self = .TokPisin

        case Server.Turkish:
            self = .Turkish

        case Server.Turkmen:
            self = .Turkmen

        case Server.Ukrainian:
            self = .Ukrainian

        case Server.Urdu:
            self = .Urdu

        case Server.Uyghur:
            self = .Uyghur

        case Server.Uzbek:
            self = .Uzbek

        case Server.Vietnamese:
            self = .Vietnamese

        case Server.Warlpiri:
            self = .Warlpiri

        case Server.Welsh:
            self = .Welsh

        case Server.Wolof:
            self = .Wolof

        case Server.Xhosa:
            self = .Xhosa

        case Server.Yakut:
            self = .Yakut

        case Server.Yiddish:
            self = .Yiddish

        case Server.Yoruba:
            self = .Yoruba

        case Server.Yucatec:
            self = .Yucatec

        case Server.Zapotec:
            self = .Zapotec

        case Server.Zulu:
            self = .Zulu

        default:
            self = .None
        }
    }

    var stringValue: String {
        switch self {
        case .None:
            return Server.None

        case .Afrikaans:
            return Server.Afrikaans

        case .Albanian:
            return Server.Albanian

        case .Amharic:
            return Server.Amharic

        case .Arabic:
            return Server.Arabic

        case .Aramaic:
            return Server.Aramaic

        case .Armenian:
            return Server.Armenian

        case .Assamese:
            return Server.Assamese

        case .Aymara:
            return Server.Aymara

        case .Azerbaijani:
            return Server.Azerbaijani

        case .Balochi:
            return Server.Balochi

        case .Bamanankan:
            return Server.Bamanankan

        case .Bashkir:
            return Server.Bashkir

        case .Basque:
            return Server.Basque

        case .Belarusian:
            return Server.Belarusian

        case .Bengali:
            return Server.Bengali

        case .Bhojpuri:
            return Server.Bhojpuri

        case .Bislama:
            return Server.Bislama

        case .Bosnian:
            return Server.Bosnian

        case .Brahui:
            return Server.Brahui

        case .Bulgarian:
            return Server.Bulgarian

        case .Burmese:
            return Server.Burmese

        case .Cantonese:
            return Server.Cantonese

        case .Catalan:
            return Server.Catalan

        case .Cebuano:
            return Server.Cebuano

        case .Chechen:
            return Server.Chechen

        case .Cherokee:
            return Server.Cherokee

        case .Croatian:
            return Server.Croatian

        case .Czech:
            return Server.Czech

        case .Dakota:
            return Server.Dakota

        case .Danish:
            return Server.Danish

        case .Dari:
            return Server.Dari

        case .Dholuo:
            return Server.Dholuo

        case .Dutch:
            return Server.Dutch

        case .English:
            return Server.English

        case .Esperanto:
            return Server.Esperanto

        case .Estonian:
            return Server.Estonian

        case .Ewe:
            return Server.Ewe

        case .Finnish:
            return Server.Finnish

        case .French:
            return Server.French

        case .Georgian:
            return Server.Georgian

        case .German:
            return Server.German

        case .Gikuyu:
            return Server.Gikuyu

        case .Greek:
            return Server.Greek

        case .Guarani:
            return Server.Guarani

        case .Gujarati:
            return Server.Gujarati

        case .HaitianCreole:
            return Server.HaitianCreole

        case .Hausa:
            return Server.Hausa

        case .Hawaiian:
            return Server.Hawaiian

        case .Hebrew:
            return Server.Hebrew

        case .Hiligaynon:
            return Server.Hiligaynon

        case .Hindi:
            return Server.Hindi

        case .Hungarian:
            return Server.Hungarian

        case .Icelandic:
            return Server.Icelandic

        case .Igbo:
            return Server.Igbo

        case .Ilocano:
            return Server.Ilocano

        case .Indonesian:
            return Server.Indonesian

        case .Inuit:
            return Server.Inuit

        case .IrishGaelic:
            return Server.IrishGaelic

        case .Italian:
            return Server.Italian

        case .Japanese:
            return Server.Japanese

        case .Jarai:
            return Server.Jarai

        case .Javanese:
            return Server.Javanese

        case .Kiche:
            return Server.Kiche

        case .Kabyle:
            return Server.Kabyle

        case .Kannada:
            return Server.Kannada

        case .Kashmiri:
            return Server.Kashmiri

        case .Kazakh:
            return Server.Kazakh

        case .Khmer:
            return Server.Khmer

        case .Khoekhoe:
            return Server.Khoekhoe

        case .Korean:
            return Server.Korean

        case .Kurdish:
            return Server.Kurdish

        case .Kyrgyz:
            return Server.Kyrgyz

        case .Lao:
            return Server.Lao

        case .Latin:
            return Server.Latin

        case .Latvian:
            return Server.Latvian

        case .Lingala:
            return Server.Lingala

        case .Lithuanian:
            return Server.Lithuanian

        case .Macedonian:
            return Server.Macedonian

        case .Maithili:
            return Server.Maithili

        case .Malagasy:
            return Server.Malagasy

        case .Malay:
            return Server.Malay

        case .Malayalam:
            return Server.Malayalam

        case .Mandarin:
            return Server.Mandarin

        case .Marathi:
            return Server.Marathi

        case .Mende:
            return Server.Mende

        case .Mongolian:
            return Server.Mongolian

        case .Nahuatl:
            return Server.Nahuatl

        case .Navajo:
            return Server.Navajo

        case .Nepali:
            return Server.Nepali

        case .Norwegian:
            return Server.Norwegian

        case .Ojibwa:
            return Server.Ojibwa

        case .Oriya:
            return Server.Oriya

        case .Oromo:
            return Server.Oromo

        case .Pashto:
            return Server.Pashto

        case .Persian:
            return Server.Persian

        case .Polish:
            return Server.Polish

        case .Portuguese:
            return Server.Portuguese

        case .Punjabi:
            return Server.Punjabi

        case .Quechua:
            return Server.Quechua

        case .Romani:
            return Server.Romani

        case .Romanian:
            return Server.Romanian

        case .Russian:
            return Server.Russian

        case .Rwanda:
            return Server.Rwanda

        case .Samoan:
            return Server.Samoan

        case .Sanskrit:
            return Server.Sanskrit

        case .Serbian:
            return Server.Serbian

        case .Shona:
            return Server.Shona

        case .Sindhi:
            return Server.Sindhi

        case .Sinhala:
            return Server.Sinhala

        case .Slovak:
            return Server.Slovak

        case .Slovene:
            return Server.Slovene

        case .Somali:
            return Server.Somali

        case .Spanish:
            return Server.Spanish

        case .Swahili:
            return Server.Swahili

        case .Swedish:
            return Server.Swedish

        case .Tachelhit:
            return Server.Tachelhit

        case .Tagalog:
            return Server.Tagalog

        case .Tajiki:
            return Server.Tajiki

        case .Tamil:
            return Server.Tamil

        case .Tatar:
            return Server.Tatar

        case .Telugu:
            return Server.Telugu

        case .Thai:
            return Server.Thai

        case .Tigrigna:
            return Server.Tigrigna
            
        case .TokPisin:
            return Server.TokPisin
            
        case .Turkish:
            return Server.Turkish
            
        case .Turkmen:
            return Server.Turkmen
            
        case .Ukrainian:
            return Server.Ukrainian
            
        case .Urdu:
            return Server.Urdu
            
        case .Uyghur:
            return Server.Uyghur
            
        case .Uzbek:
            return Server.Uzbek
            
        case .Vietnamese:
            return Server.Vietnamese
            
        case .Warlpiri:
            return Server.Warlpiri
            
        case .Welsh:
            return Server.Welsh
            
        case .Wolof:
            return Server.Wolof
            
        case .Xhosa:
            return Server.Xhosa
            
        case .Yakut:
            return Server.Yakut
            
        case .Yiddish:
            return Server.Yiddish
            
        case .Yoruba:
            return Server.Yoruba
            
        case .Yucatec:
            return Server.Yucatec
            
        case .Zapotec:
            return Server.Zapotec
            
        case .Zulu:
            return Server.Zulu
        }
    }

}

extension LanguageLevel {

    private typealias Server = String.Server.LanguageLevel

    init(stringValue: String) {
        switch stringValue {
        case Server.Beginner:
            self = .Beginner

        case Server.Intermediate:
            self = .Intermediate

        case Server.Advanced:
            self = .Advanced

        case Server.Fluent:
            self = .Fluent

        case Server.Native:
            self = .Native

        default:
            self = .None
        }
    }

    var stringValue: String {
        switch self {
        case .None:
            return Server.None

        case .Beginner:
            return Server.Beginner

        case .Intermediate:
            return Server.Intermediate

        case .Advanced:
            return Server.Advanced

        case .Fluent:
            return Server.Fluent

        case .Native:
            return Server.Native
        }
    }
    
}
