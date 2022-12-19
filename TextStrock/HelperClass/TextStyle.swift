//
//  TextStyle.swift
//  TextStrock
//
//  Created by PosterMaker on 12/14/22.
//

import UIKit


class TextShadow{
    var offset:CGSize
    var color:UIColor
    var blur:CGFloat
    var opacity:CGFloat
    
    init(offset: CGSize, color: UIColor, blur: CGFloat, opacity: CGFloat) {
        self.offset = offset
        self.color = color
        self.blur = blur
        self.opacity = opacity
    }
}

class TextOutLine{
    var color:UIColor?
    var gragientColor:GradientColor?
    var lineWidth:CGFloat
    init(color: UIColor? = nil,gragientColor:GradientColor? = nil , lineWidth: CGFloat) {
        self.color = color
        self.gragientColor = gragientColor
        self.lineWidth = lineWidth
    }
}

class TextGradientColor{
    private var firstColorHexValue:String
    private var secondColorHexValue:String
    var gradientColor:GradientColor
    var angle:CGFloat
    
    init(firstColorHexValue: String, secondColorHexValue: String,angle:CGFloat) {
        self.firstColorHexValue = firstColorHexValue
        self.secondColorHexValue = secondColorHexValue
        self.angle = angle
        
        let fColor = UIColor.hexStringToUIColor(hex: firstColorHexValue)
        let sColor = UIColor.hexStringToUIColor(hex: secondColorHexValue)
        self.gradientColor = GradientColor(firstColor: fColor, secondColor: sColor)
    }
    
}

//class TextTexture{
//    var imageName:String
//    init(imageName: String) {
//        self.imageName = imageName
//    }
//}

class TextStyle{
    var shadow:TextShadow?
    var outLine:TextOutLine?
    var gradientColor:TextGradientColor?
    var texture:Texture?
    var textColor:UIColor?
    
    var fontName:String?
    var fontSize:CGFloat?
    
    var spacingV:CGFloat?
    
    init(shadow: TextShadow? = nil, outLine: TextOutLine? = nil, gradientColor: TextGradientColor? = nil, texture: Texture? = nil, textColor: UIColor? = nil, fontName: String? = nil, fontSize: CGFloat? = nil, spacingV: CGFloat? = nil) {
        self.shadow = shadow
        self.outLine = outLine
        self.gradientColor = gradientColor
        self.texture = texture
        self.textColor = textColor
        self.fontName = fontName
        self.fontSize = fontSize
        self.spacingV = spacingV
    }
    
}



class TextStyleLists{
    var styles:[TextStyle] = []
    
    init(){
        styleAdd()
    }
    
    private func styleAdd(){
        let tex = TextTexture()
        
        
        let sColor1 = UIColor.hexStringToUIColor(hex: "#65647C")
        let shadow1 = TextShadow(offset: CGSize(width: 6, height: 6), color: sColor1, blur: 8.0, opacity: 0.7)
        
        let gradientColor1 = TextGradientColor(firstColorHexValue: "#DEBACE", secondColorHexValue: "#285430", angle: 90.0)
        let style1 = TextStyle(shadow: shadow1,gradientColor: gradientColor1,fontName: "Oswald-Bold")
        styles.append(style1)
        
        
        
        let sColor2 = UIColor.hexStringToUIColor(hex: "#2B3A55")
        let shadow2 = TextShadow(offset: CGSize(width: 10, height: 4), color: sColor2, blur: 4.0, opacity: 1.0)
        let outLine2 = TextOutLine(color: UIColor.hexStringToUIColor(hex: "#65647C"), lineWidth: 6.0)
        
        let style2 = TextStyle(shadow: shadow2,outLine: outLine2,textColor:.clear, fontName: "mvboli")
        styles.append(style2)
        
        //
        
        
        let sColor3 = UIColor.hexStringToUIColor(hex: "#282A3A")
        let shadow3 = TextShadow(offset: CGSize(width: 6, height: 6), color: sColor3, blur: 2, opacity: 1.0)
        let outLine3 = TextOutLine(color: UIColor.hexStringToUIColor(hex: "#3F3B6C"), lineWidth: 4.0)
        let style3 = TextStyle(shadow: shadow3,outLine: outLine3,texture: tex.textures[11],fontName: "Crowers")
        styles.append(style3)
        
        
        
        let sColor4 = UIColor.hexStringToUIColor(hex: "#FF8E9E")
        let shadow4 = TextShadow(offset: CGSize(width: -2, height: 6), color: sColor4, blur: 2.0, opacity: 0.6)
        let outLine4 = TextOutLine(color: UIColor.hexStringToUIColor(hex: "#393E46"), lineWidth: 8.0)
        let gradientColor4 = TextGradientColor(firstColorHexValue: "#FB2576", secondColorHexValue: "#3F0071", angle: 90.0)
        let style4 = TextStyle(shadow: shadow4,outLine: outLine4,gradientColor: gradientColor4,fontName: "Vermin-Vibes-Roundhouse")
        styles.append(style4)
        
        
        let outLine5 = TextOutLine(color: UIColor.hexStringToUIColor(hex: "#393E46"), lineWidth: 4.0)
        let style5 = TextStyle(outLine: outLine5,texture: tex.textures[30],fontName: "MONOGRAMOS")
        styles.append(style5)
        
        let sColor6 = UIColor.hexStringToUIColor(hex: "#6B728E")
        let shadow6 = TextShadow(offset: CGSize(width: -2, height: -6), color: sColor6, blur: 10.0, opacity: 1.0)
        let outLine6 = TextOutLine(color: UIColor.hexStringToUIColor(hex: "#6B728E"), lineWidth: 10.0)
        let gradientColor6 = TextGradientColor(firstColorHexValue: "#E97777", secondColorHexValue: "#557153", angle: 0.0)
        let style6 = TextStyle(shadow: shadow6,outLine: outLine6,gradientColor: gradientColor6,fontName: "Wildstone")
        styles.append(style6)
        
        
        let sColor7 = UIColor.hexStringToUIColor(hex: "#FF8E9E")
        let shadow7 = TextShadow(offset: CGSize(width: 2, height: 2), color: sColor7, blur: 10.0, opacity: 1.0)
        let outLine7 = TextOutLine(color: UIColor.hexStringToUIColor(hex: "#000000"), lineWidth: 2.0)
        let gradientColor7 = TextGradientColor(firstColorHexValue: "#FFE1E1", secondColorHexValue: "#7DE5ED", angle: 90.0)
        let style7 = TextStyle(shadow: shadow7,outLine: outLine7,gradientColor: gradientColor7,fontName: "Blantic")
        styles.append(style7)
        
        
        let sColor8 = UIColor.hexStringToUIColor(hex: "#7DE5ED")
        let shadow8 = TextShadow(offset: CGSize(width: -4, height: 2), color: sColor8, blur: 0.0, opacity: 1.0)
        let outLine8 = TextOutLine(color: UIColor.hexStringToUIColor(hex: "#5F9DF7"), lineWidth: 14.0)
        let gradientColor8 = TextGradientColor(firstColorHexValue: "#5F9DF7", secondColorHexValue: "#1746A2", angle: 90.0)
        let style8 = TextStyle(shadow: shadow8,outLine: outLine8,gradientColor: gradientColor8,fontName: "clutsy")
        styles.append(style8)
        
        let sColor9 = UIColor.hexStringToUIColor(hex: "#A149FA")
        let shadow9 = TextShadow(offset: CGSize(width: 2, height: 2), color: sColor9, blur: 2, opacity: 1.0)
        let style9 = TextStyle(shadow: shadow9,texture: tex.textures[47],fontName: "PRISTINA")
        styles.append(style9)
        
        let sColor10 = UIColor.hexStringToUIColor(hex: "#D800A6")
        let shadow10 = TextShadow(offset: CGSize(width: 5, height: 2), color: sColor10, blur: 0.0, opacity: 1.0)
        let outLine10 = TextOutLine(color: UIColor.hexStringToUIColor(hex: "#31E1F7"), lineWidth: 4.0)
        
        let style10 = TextStyle(shadow: shadow10,outLine: outLine10,textColor: .clear,fontName: "NEON")
        styles.append(style10)
        
        let sColor11 = UIColor.hexStringToUIColor(hex: "#2B3A55")
        let shadow11 = TextShadow(offset: CGSize(width: 6, height: 4), color: sColor11, blur: 2.0, opacity: 1.0)
        
        let color11 = UIColor(red: 0/255, green: 255/255, blue: 209/255, alpha: 0.2)
        
        let style11 = TextStyle(shadow: shadow11,textColor:color11, fontName: "mvboli")
        styles.append(style11)
        
        
        let sColor12 = UIColor.hexStringToUIColor(hex: "#2B3A55")
        let shadow12 = TextShadow(offset: CGSize(width: 6, height: 4), color: sColor12, blur: 8.0, opacity: 1.0)
        
        let style12 = TextStyle(shadow: shadow12,texture: tex.textures[69], fontName: "El-RioLobo")
        styles.append(style12)
        
        
        
        
        let sColor13 = UIColor.hexStringToUIColor(hex: "#0014FF")
        let shadow13 = TextShadow(offset: CGSize(width: 0, height: 0), color: sColor13, blur: 15.0, opacity: 0.4)
        
        let gColor13 = GradientColor(firstColor: UIColor.hexStringToUIColor(hex: "#FB2576"), secondColor: UIColor.hexStringToUIColor(hex: "#0014FF"))
        let outLine13 = TextOutLine(gragientColor: gColor13, lineWidth: 14.0)
        
        let style13 = TextStyle(shadow: shadow13,outLine: outLine13,textColor: .clear, fontName: "Magical Signature")
        styles.append(style13)
        
        
        let outLine14 = TextOutLine(color: UIColor.hexStringToUIColor(hex: "#06283D"), lineWidth: 16.0)
        let style14 = TextStyle(outLine: outLine14,texture: tex.textures[89], fontName: "TobaccoRoadNF")
        styles.append(style14)
        
        
        
        
        
        
        let sColor15 = UIColor.hexStringToUIColor(hex: "#FB2576")
        let shadow15 = TextShadow(offset: CGSize(width: -6, height: 2), color: sColor15, blur: 0.0, opacity: 1.0)
        
        let style15 = TextStyle(shadow: shadow15,textColor: UIColor.hexStringToUIColor(hex: "#00E7FF"), fontName: "bauhaus 93")
        styles.append(style15)
        
        
    }
}
