//
//  CustomLabel.swift
//  TextStrock
//
//  Created by PosterMaker on 11/22/22.
//

import UIKit

class CustomLabel: UILabel {
    
     var texture:Texture? = nil
    
     var textGradientColor:GradientColor? = nil
    private var textGradientAngel:CGFloat = 0.0
    
    private var strockGradientColor:GradientColor? = nil
    private var strockGradientAngel:CGFloat = 0.0
    
    private var strockColor = UIColor.blue
    private var strocklineWidth:CGFloat = 0.0
    private var clearColor = UIColor.clear
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func drawText(in rect: CGRect) {
        
        let shadowOffset = self.shadowOffset
        let textColor = self.textColor
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        
        //--------strock draw------------
        context.setLineWidth(strocklineWidth)
        context.setLineJoin(.round)
        context.setTextDrawingMode(.stroke)
        
        if strockGradientColor != nil{
            //Gradient Color Add
            if let gColor = strockGradientColor{
                let newColor = gColor.getGradientUIColor(in: rect,angle: strockGradientAngel)
                self.textColor = newColor
            }
        } else {
            //linear color add
            self.textColor = strockColor
        }
        super.drawText(in: rect)
        
        //--------text draw------------
        context.setTextDrawingMode(.fill)
        
        if texture != nil{
            //texture Add
            if let textTexture = texture{
                let newColor = textTexture.getTextureUIColor(in: rect)
                self.textColor = newColor
            }
        } else if textGradientColor != nil{
            //Gradient Color Add
            if let gColor = textGradientColor{
                let newColor = gColor.getGradientUIColor(in: rect,angle: textGradientAngel)
                self.textColor = newColor
            }
        } else {
            //linear color add
            self.textColor = textColor
        }
        
        self.shadowOffset = CGSize(width: 0, height: 0)
        
        if textColor == .clear{
            context.setBlendMode(.clear)
        }
        
        super.drawText(in: rect)
        self.shadowOffset = shadowOffset
        context.restoreGState()
        
    }
    
    func strockSizeChange(value:CGFloat){
        self.strocklineWidth = value
        self.setNeedsDisplay()
    }
    
    func strockColorChange(color:UIColor){
        self.strockGradientColor = nil
        self.strockColor = color
        self.setNeedsDisplay()
    }
    
    func strockGradientColorAdd(gColor:GradientColor,angel:CGFloat = 0.0){
        strockGradientAngel = angel
        strockGradientColor = gColor
        setNeedsDisplay()
    }
    
    func textColorChange(color:UIColor){
        //print("color = \(color)")
        self.textColor = color
        texture = nil
        textGradientColor = nil
        textGradientAngel = 0.0
        
        
        setNeedsDisplay()
    }
    
    func textGradientColorAdd(gColor:GradientColor,angel:CGFloat = 0.0){
        self.textColor = nil
        texture = nil
        textGradientAngel = angel
        textGradientColor = gColor
        setNeedsDisplay()
    }
    
    func textTextureChange(textTexture:Texture){
        self.textColor = nil
        textGradientColor = nil
        textGradientAngel = 0.0
    
        texture = textTexture
        setNeedsDisplay()
    }
    
    

}

