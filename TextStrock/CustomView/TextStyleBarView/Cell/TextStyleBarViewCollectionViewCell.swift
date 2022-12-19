//
//  TextStyleBarViewCollectionViewCell.swift
//  TextStrock
//
//  Created by PosterMaker on 12/14/22.
//

import UIKit

class TextStyleBarViewCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var label: CustomLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setupCell(text:String,style:TextStyle,isSelected:Bool){
        self.backgroundColor = .clear
        label.frame = self.bounds
        
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 8.0
        
        label.textAlignment = .center
        label.text = style.fontName ?? "Style"
        applyStyle(style: style)
        
        if isSelected{
            cellSelectedAction()
        }
        
    }
    
    func cellSelectedAction(){
        self.backgroundColor = UIColor.hexStringToUIColor(hex: "#C3F8FF")
        self.layer.borderColor = UIColor.hexStringToUIColor(hex: "#ABD9FF").cgColor
    }
    
    
    private func applyStyle(style:TextStyle){
        
        if let fontName = style.fontName {
            label.font = UIFont(name: fontName, size: 24.0)
        }
        
        if let fontcolor = style.textColor {
            label.textColorChange(color: fontcolor)
        }
        
        if let fontGradientColor = style.gradientColor {
            label.textGradientColorAdd(gColor: fontGradientColor.gradientColor,angel: fontGradientColor.angle)
        }else {
            label.textGradientColor = nil
        }
        
        if let texture = style.texture {
            label.textTextureChange(textTexture: texture)
        } else {
            label.texture = nil
        }
        
        if let shadow = style.shadow {
            label.layer.shadowColor = shadow.color.cgColor
            label.layer.shadowOffset = shadow.offset
            label.layer.shadowRadius = shadow.blur
            label.layer.shadowOpacity = Float(shadow.opacity)
        } else {
            label.layer.shadowColor = UIColor.clear.cgColor
            label.layer.shadowOffset = CGSize(width: 0, height: 0)
            label.layer.shadowRadius = 0.0
            label.layer.shadowOpacity = 0.0
        }
        
        if let outLine = style.outLine {
            label.strockSizeChange(value: outLine.lineWidth)
            if let oColor = outLine.color{
                label.strockColorChange(color: oColor)
            }
            if let ogColor = outLine.gragientColor{
                label.strockGradientColorAdd(gColor: ogColor)
            }
            
        } else{
            label.strockSizeChange(value: 0.0)
            label.strockColorChange(color: .white)
        }
        
        //customLabelResize()
    }

}
