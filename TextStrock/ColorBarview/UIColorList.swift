//
//  File.swift
//  TextStrock
//
//  Created by PosterMaker on 11/24/22.
//


import UIKit


extension UIColor{
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func hexStringToCIVector(hex:String) -> CIVector {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return CIVector(x:0.33, y: 0.98, z: 0.25)
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        let x = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let y = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let z = CGFloat(rgbValue & 0x0000FF) / 255.0

        return CIVector(x: x, y: y, z: z)
    }
}

class UIColorList{
    var tomato:[String] = ["#ffb192","#FF7F50","#FF4500","#d13900",
    "#FFFACD","#EEE8AA","#c9c485","#9b9658","#ffff73","#FFFF00","#e8e800","#FFDAB9","#D1B398"]
    var orange:[String] = ["#ffd68b","#FFA500","#a36a00"]
    var magento = ["#ff73ff","#d100d1","#740074"]
    var purple = ["#AE5CAE","#800080","#3b003b"]
    var indigo = ["#ad8bc6","#8c6caf","#6b2e98","#290047"]
    var green = ["#8bc58b","#2e972e","#006900"]
    var lime = ["#00FF00","#00d100","#004600"]
    var yellowGreen = ["#9ACD32","#638329","#2a380e"]
    var olive = ["#c5c58b","#97972e","#525200","#66CDAA","#20B2AA"]
    var cyan = ["#b9ffff","#00FFFF","#007474"]
    var mediumSlateBlue = ["#c3baf7","#ab9ef4","#7B68EE","#4f4398"]
    var blue = ["#8b8bff","#5c5cff","#0000a3","#000046"]
    var deepSkyBlue = ["#98ccff","#46a4ff","#1976D1","#092846"]
    var navajuWhite = ["#e8ca9e","#7e6d56"]
    var white = ["#d2d2e4","#BEC5CC","#8A97A4","#48525C"]
    var gray = ["#FFFFFF","#e7e7e7","#696969","#000000"]
    var pink = ["#ffedf0","#FFC0CB","#E8AFB9","#8C696F"]
    var brown = ["#d69e9e","#c57777","#A52A2A","#6a1b1b","#fad5bc","#F4A460","#c8874f","#432d1b"]
    var deeppink:[String] = ["#FFBEE1","#FF69BA","#FF1493","#D11179","#ffa2a2","#ff5c5c","#FF0000","#A30000","#740000"]
    var colorNameList:[String] = []
    var uiColorList:[UIColor] = []
    init(){
        setupColorList()
    }
    
    private func setupColorList(){
        
        
        colorNameList = white + gray + tomato + orange + magento + purple + indigo + green + lime + yellowGreen + olive + cyan + mediumSlateBlue + blue + deepSkyBlue + navajuWhite + pink + brown + deeppink
        
        for colorname in colorNameList {
            let color = UIColor.hexStringToUIColor(hex: colorname)
            uiColorList.append(color)
        }
    }
    
}
