//
//  CustomLabel.swift
//  TextStrock
//
//  Created by PosterMaker on 11/22/22.
//

import UIKit

class CustomLabel: UILabel {
    let lineWidth:CGFloat = 5
    
    override func drawText(in rect: CGRect) {
        
        let shadowOffset = self.shadowOffset
        let textColor = self.textColor
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        context.setLineWidth(lineWidth)
        context.setLineJoin(.round)
        context.setTextDrawingMode(.stroke)
        self.textColor = .blue
        
        super.drawText(in: rect)
        
        context.setTextDrawingMode(.fill)
        self.textColor = textColor
        self.shadowOffset = CGSize(width: 0, height: 0)
        
        super.drawText(in: rect)
        
        self.shadowOffset = shadowOffset
        
        
//        CGSize shadowOffset = self.shadowOffset;
//          UIColor *textColor = self.textColor;
//
//          CGContextRef c = UIGraphicsGetCurrentContext();
//          CGContextSetLineWidth(c, 1);
//          CGContextSetLineJoin(c, kCGLineJoinRound);
//
//          CGContextSetTextDrawingMode(c, kCGTextStroke);
//          self.textColor = [UIColor whiteColor];
//          [super drawTextInRect:rect];
//
//          CGContextSetTextDrawingMode(c, kCGTextFill);
//          self.textColor = textColor;
//          self.shadowOffset = CGSizeMake(0, 0);
//          [super drawTextInRect:rect];
//
//          self.shadowOffset = shadowOffset;
//
        
    }

}
