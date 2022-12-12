//
//  CustomLabelNew.swift
//  TextStrock
//
//  Created by PosterMaker on 12/12/22.
//

import UIKit

class CustomLabelNew: UILabel
{
    var lineHeight: CGFloat!
    var requiredNumberOfLines: Int!
    
    override var numberOfLines: Int
    {
        get
        {
            return requiredNumberOfLines
        }
        set
        {
            requiredNumberOfLines = newValue
            super.numberOfLines = 0
        }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect
    {
        func snapToScreenScale(_ length: CGFloat) -> CGFloat
        {
            let scale = UIScreen.main.scale
            return ceil(length * scale) / scale
        }
        
        func compensation() -> CGFloat
        {
            // text inside line area is attached to bottom and may be clipped at top
            // so to compensate clipping we should add difference between required and original line heights
            let topCompensation = max(
                0,
                snapToScreenScale(
                    font.lineHeight - lineHeight
                )
            )
            
            // lines of text are centered verticaly in label's bounds
            // so to compensate top clipping completely we should add equal extra space at top and bottom
            let compensation = topCompensation * 2
            
            return compensation
        }
        
        var rect = super.textRect(
            forBounds: bounds,
            limitedToNumberOfLines: numberOfLines
        )
        rect.size = .init(
            width: snapToScreenScale(rect.width),
            height: snapToScreenScale(rect.height)
        )
        rect.size.height += compensation()
        
        return rect
    }
}
