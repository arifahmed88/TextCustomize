//
//  TextFont.swift
//  TextStrock
//
//  Created by PosterMaker on 11/27/22.
//

import UIKit

class AllFonts {
    static let shared = AllFonts()
    
    var availableFonts:[TextFont] = []
    private init() {
        setAllFonts()
    }
    
    
    func setAllFonts() {
        UIFont.loadAllFonts()
        var uniquesFontsSet = Set<String>()
        for family in UIFont.familyNames {
            let names = UIFont.fontNames(forFamilyName: family)
            names.forEach { (fontName) in
                uniquesFontsSet.insert(fontName)
            }
        }
        
        for fontName in uniquesFontsSet {
            availableFonts.append(TextFont(fontName: fontName))
        }
        
        availableFonts =  availableFonts.sorted(by: { lhs, rhs in
            return (String(lhs.fontName ?? "")) < String(rhs.fontName ?? "")
        })
    }
    
    private func showAllFontsName() {
        print("All fonts name")
        for font in availableFonts {
            if let fontName = font.fontName {
                print("\(fontName)")
            }
        }
    }
    
    func fontWithHeightIssue() -> [String] {
        return [
        "AltavistaPersonalUse",
        "CooperHewitt-Heavy",
        "SedgwickAveDisplay-Regular",
        "SugarpunchDEMO",
        ]
    }
    
    func getUsedFonts() -> [String] {
        return [
            "Acme-Regular",
            "AdelarsioRegular",
            "AltavistaPersonalUse",
            "AnotherDangerDemo",
            "ArialRoundedMTBold",
            "Arizonia-Regular",
            "Azedo-Bold",
            "Azedo-Light",
            "BACKCOUNTRY-Regular",
            "Balans-Normal",
            "BalooBhai-Regular",
            "Bauhaus93",
            "BeautyandtheBeast",
            "BunnyHopperEarRegular",
            "CabinSketch-Bold",
            "Campanile",
            "Candle Mustard",
            "Cardinal-Regular",
            "Charm-Bold",
//            "ChocolateDealer-Bold",
//            "CocoBikeR",
            "CooperHewitt-Heavy",
            "CoveredByYourGrace",
            "Cute Jellyfish",
            "DancingScript-Bold",
            "DancingScript",
            "Dosis-SemiBold",
            "DoubleBubbleShadow",
            "EdwardianScriptITC",
            "El-RioLobo",
            "EmpiresRegular",
            "ErasITC-Bold",
            "FightingSpiritturbo",
            "FingerPaint-Regular",
            "FreckleFace-Regular",
            "FreestyleScript-Regular",
            "FreestyleScriptPlain",
            "FrenchScriptMT",
            "FunnyKid",
            "Futura-Bold",
            "GoudyOldStyleT-Bold",
            "GreatVibes-Regular",
            "HalloweenToo",
            "Harabara",
            "Helvetica",
            "Helvetica-Bold",
            "Helvetica-Compressed",
            "HennyPenny-Regular",
            "HerrVonMuellerhoff-Regular",
            "HotChocolateLatte",
            "HoboStd",
            "Impact",
            "Jattestor",
            "JavaneseText",
//            "KahunaIsland",
            "KallamarStout",
            "KashimaBrushDemo",
            "Kristi-Regular",
            "Lato-Regular",
            "Lato-Bold",
            "LeckerliOne",
//            "LeckerliOne-Regular",
            "LeelawadeeBold",
            "Leelawadee",
            "Lexia-Bold",
            "Lexia",
            "LinguisticsPro-Italic",
            "LinguisticsPro-Bold",
            "LinguisticsPro-Regular",
            "LithosPro-Black",
            "LobsterTwo",
            "LucidaCalligraphy-Italic",
            "MMSTROKESRegular",
            "MONOGRAMOS",
            "MVBoli",
            "MaiandraGD-Regular",
            "Meddon",
            "Mellows",
            "Merienda-Bold",
            "MetalMania-Regular",
            "Mistral",
            "MongolianBaiti",
            "Montserrat-Black",
            "Montserrat-ExtraBold",
            "MountainsofChristmas-Bold",
            "Neon",
            "Nexa-Bold",
            "NexaRustSans-Black",
            "NexaRustScriptL-1",
            "NexaRegular",
            "OCRAExtended",
            "OliversBarney-Regular",
            "OpenSans-Regular",
            "OpenSans-Bold",
            "OpenSans-SemiBoldItalic",
            "OpenSans-Light",
            "OpenSans-SemiBold",
            "Oswald-Regular",
            "Oswald-Medium",
            "Oswald-Light",
            "Oswald-Bold",
            "Pacifico-Regular",
            "PalaceScriptMT",
            "Perpetua",
            "PlaneCrash",
            "PlasticFantasticDEMO-Regular",
            "PoorRichard-Regular",
            "Poppins-SemiBold",
            "Poppins-Regular",
            "Poppins-Medium",
            "Potra",
            "Pristina-Regular",
            "Quicksand-Bold",
            "Quicksand-Medium",
            "Raleway-Bold",
            "Rhesmanisa-Regular",
            "Righteous-Regular",
            "Roboto-Regular",
            "Roboto-Black",
            "Roboto-Medium",
            "Roboto-Bold",
            "Roboto-BlackItalic",
            "Roboto-Light",
            "Rockwell",
            "RuslanDisplay",
            "SFChaerilidae",
            "SFChaerilidae-Bold",
            "SFChaerilidae-BoldOblique",
            "Sacramento-Regular",
            "Saira-Bold",
            "Saira-SemiBold",
            "SandrinaRegular",
            "Sansation-Bold",
            "Sansation-Regular",
            "Satisfy-Regular",
            "ScriptMTBold",
            "SedgwickAveDisplay-Regular",
            "SegoePrint-Bold",
            "SegoeScript-Bold",
            "SegoeUI-Semibold",
            "SegoeUIBlack",
            "SegoeUI-Bold",
            "SegoeUI",
            "SingaporeSling3D",
//            "Slow-Life",
            "Slow Life",
            "Smasher312Custom",
            "SnubnoseDEMO-Regular",
            "SourceSansPro-Light",
            "SourceSansPro-Regular",
            "SourceSansPro-Semibold",
            "SourceSansPro-Black",
            "Stea",
            "Stella",
            "StencilStd",
            "StrawberryBlossom",
            "SugarpunchDEMO",
            "Tangerine-Bold",
            "TobaccoRoadNF",
            "TradeWinds",
            "UrbanJungleDEMO",
            "Vermin-Vibes-Roundhouse",
            "WeltronUrban",
            "Westmeath",
            "WildOnes",
            "Yesteryear-Regular",
            "ZenzaiItacha"
        ]
    }
}

class TextFont {
    let fontName: String?
    var isSelected: Bool = false
    var isPrmium: Bool = false
    
    var minimumSpacing: Float = 0
    var minimumSpacingMultiplyer: Float = 0
    
    init() {
        self.fontName = ""
    }
    
    init(fontName: String) {
        self.fontName = fontName
    }
    
    static func getAllFonts() -> [TextFont] {
        var availableFonts:[TextFont] = []
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            names.forEach { (fontName) in
                print("indivudal Font name: \(fontName)\n")
                let textFont = TextFont(fontName: fontName)
                availableFonts.append(textFont)
            }
        }
        return availableFonts
    }
    
    static func getSelectedFontIndex(selectedFontName: String, fonts: [TextFont]) -> Int? {
        for (index, textFont) in fonts.enumerated() {
            if textFont.fontName == selectedFontName {
                return index
            }
            if let fontName = textFont.fontName {
                if let matchedFontName = selectedFontName.getCorrectFontName(),
                   matchedFontName == fontName {
                    return index
                }
                
            }
        }
        return nil
    }


    
    static func getSelectedIndexPath(fonts: [TextFont]) -> Int? {
        for (index, textFont) in fonts.enumerated() {
            if textFont.isSelected {
                return index
            }
        }
        return nil
    }
}
