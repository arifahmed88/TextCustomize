//
//  CustomlabelSecond.swift
//  TextStrock
//
//  Created by PosterMaker on 12/6/22.
//

import UIKit

class CustomlabelSecond: UILabel {
    let shapelayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        shapelayer.strokeColor = UIColor.blue.cgColor
        shapelayer.fillColor = UIColor.clear.cgColor
        shapelayer.lineWidth = 1.0
        self.layer.addSublayer(shapelayer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        shapelayer.strokeColor = UIColor.blue.cgColor
        shapelayer.fillColor = UIColor.clear.cgColor
        shapelayer.lineWidth = 1.0
        self.layer.addSublayer(shapelayer)
    }
    
    
    override func drawText(in rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        shapelayer.frame = self.bounds
        shapelayer.path = path.cgPath
        
        super.drawText(in: rect)
    }
}
