//
//  CustomLabel.swift
//  TextStrock
//
//  Created by PosterMaker on 11/22/22.
//

import UIKit

class CustomLabel: UILabel {
    
    private var textGradientColor:GradientColor? = nil
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        
        let shadowOffset = self.shadowOffset
        let textColor = self.textColor
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
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
        
        
        context.setTextDrawingMode(.fill)
        if textGradientColor != nil{
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
    
    func textColorChange(color:UIColor){
        textGradientColor = nil
        textGradientAngel = 0.0
        
        textColor = color
        setNeedsDisplay()
    }
    
    func textGradientColorAdd(gColor:GradientColor,angel:CGFloat = 0.0){
        textColor = nil
        textGradientAngel = angel
        textGradientColor = gColor
        print("gColor = \(gColor.firstColor)")
        setNeedsDisplay()
    }
    
    func strockGradientColorAdd(gColor:GradientColor,angel:CGFloat = 0.0){
        strockGradientAngel = angel
        strockGradientColor = gColor
        setNeedsDisplay()
    }

}

