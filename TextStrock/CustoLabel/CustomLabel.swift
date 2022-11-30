//
//  CustomLabel.swift
//  TextStrock
//
//  Created by PosterMaker on 11/22/22.
//

import UIKit

class CustomLabel: UILabel {
    
    var gradientColor:GradientColor? = nil
    var gradientAngel:CGFloat = 0.0
    
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
        self.textColor = strockColor
        super.drawText(in: rect)
        
        
        context.setTextDrawingMode(.fill)
        
        
        if gradientColor != nil{
            //Gradient Color Add
            if let gColor = gradientColor{
                let newColor = gColor.getGradientUIColor(in: rect,angle: gradientAngel)
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
        
    }
    
    func strockSizeChange(value:CGFloat){
        self.strocklineWidth = value
        self.setNeedsDisplay()
    }
    
    func strockColorChange(color:UIColor){
        self.strockColor = color
        self.setNeedsDisplay()
    }
    
    func textColorChange(color:UIColor){
        gradientColor = nil
        gradientAngel = 0.0
        
        textColor = color
        setNeedsDisplay()
    }
    
    func textGradientColorAdd(gColor:GradientColor,angel:CGFloat = 0.0){
        gradientAngel = angel
        gradientColor = gColor
        setNeedsDisplay()
    }

}

