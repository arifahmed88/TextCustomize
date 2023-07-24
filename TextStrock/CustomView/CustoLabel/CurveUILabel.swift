//
//  CurveUILabel.swift
//  TextStrock
//
//  Created by PosterMaker on 12/18/22.
//

import UIKit

@IBDesignable
class CurveUILabel: UILabel {
//    var inflection:CGFloat = 0.0
    @IBInspectable var angle: CGFloat = (90)*(.pi/180)
    @IBInspectable var clockwise: Bool = true
    var sliderValue:CGFloat = 0.0
    var fontSpace:CGFloat = 0.0
    var reverseAngle = false
    
    var curveLabelHeightOffset:CGFloat = 30
    var curveLabelWidthOffset:CGFloat = 30
    
    
    override func draw(_ rect: CGRect) {
        centreArcPerpendicular()
    }
    
    
    func labelWidthCalculation(){
        let textSize = self.text?.size(withAttributes: [NSAttributedString.Key.font: self.font ?? UIFont.boldSystemFont(ofSize: CGFloat(10.0))])
//        print("oni = \(textSize)")
        
        //width calculation
        let s = textSize!.width
        guard let r = getRadiusForLabel() else {
            return
        }
        let theta = s/r
        
        let p = (r*sin(theta/2))
        let resizedWidth = 2*p
        
        //height calculation
        let q = p/(tan(theta/2))
        let resizedHeight = r - q
        
        self.bounds.size.width = resizedWidth+(curveLabelWidthOffset*2)
        self.bounds.size.height = resizedHeight+(curveLabelHeightOffset)
    }
    
    func centreArcPerpendicular() {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let str = self.text ?? ""
        let size = self.bounds.size

        let flag:CGFloat = reverseAngle ? -1 : 1
            
        let point = CGPoint(x: size.width / 2, y: (size.height / 2)+((sliderValue)*flag))
        print("auny point = \(point)")
        
        context.translateBy(x: point.x, y: point.y)
        
        guard let radius = getRadiusForLabel() else {
            return
        }
        
        
        print("radius = \(radius)")
        
        
        let l = str.count
        
        let textColor = self.textColor ?? .darkGray
        let textFont = self.font ?? UIFont.boldSystemFont(ofSize: CGFloat(24.0))
        let attributes : [NSAttributedString.Key : Any] = [.font : textFont,.foregroundColor : textColor]
        
        
        
        let characters: [String] = str.map { String($0) } // An array of single character strings, each character in str
        var arcs: [CGFloat] = [] // This will be the arcs subtended by each character
        var totalArc: CGFloat = 0 // ... and the total arc subtended by the string
        
        // Calculate the arc subtended by each letter and their total
        for i in 0 ..< l {
            
            arcs += [chordToArc(characters[i].size(withAttributes: attributes).width+fontSpace, radius: radius)]
            
            totalArc += arcs[i]
        }
        
        // Are we writing clockwise (right way up at 12 o'clock, upside down at 6 o'clock)
        // or anti-clockwise (right way up at 6 o'clock)?
        let direction: CGFloat = clockwise ? -1 : 1
        let slantCorrection = clockwise ? -CGFloat(Double.pi/2) : CGFloat(Double.pi/2)
        
        // The centre of the first character will then be at
        // thetaI = theta - totalArc / 2 + arcs[0] / 2
        // But we add the last term inside the loop
//        print("auny angle = \(angle)")
//        print("auny direction = \(direction)")
//        print("auny totalArc = \(totalArc)")
        var thetaI = angle - direction * totalArc / 2
//        print("auny thetaI = \(thetaI)")
        
        for i in 0 ..< l {
            thetaI += direction * arcs[i] / 2
            // Call centre with each character in turn.
            // Remember to add +/-90º to the slantAngle otherwise
            // the characters will "stack" round the arc rather than "text flow"
            var pColor:UIColor
            if i == 0 {
                pColor = .red
            } else {
                pColor = .green
            }
            if i == 0 {
                centre(text: characters[i], context: context, radius: radius, angle: thetaI, slantAngle: thetaI + slantCorrection,pointColor: pColor,isFirst: true,islast: false)
            } else if i == (l-1){
                centre(text: characters[i], context: context, radius: radius, angle: thetaI, slantAngle: thetaI + slantCorrection,pointColor: pColor,isFirst: false,islast: true)
            } else{
                centre(text: characters[i], context: context, radius: radius, angle: thetaI, slantAngle: thetaI + slantCorrection,pointColor: pColor,isFirst: false,islast: false)
            }
            
            
            // The centre of the next character will then be at
            // thetaI = thetaI + arcs[i] / 2 + arcs[i + 1] / 2
            // but again we leave the last term to the start of the next loop...
            thetaI += direction * arcs[i] / 2
        }
    }
    
    func chordToArc(_ chord: CGFloat, radius: CGFloat) -> CGFloat {
        print("auny --start-- ")
        print("auny chord = \(chord)")
        print("auny radius = \(radius)")
        print("auny (2 * radius) = \((2 * radius))")
        print("auny chord / (2 * radius) = \(chord / (2 * radius))")
        
        var value = chord / (2 * radius)
        if value < -1.0{
            value = -1.0
        } else if value > 1.0{
            value = 1.0
        }
        
        print("auny asin(chord / (2 * radius) = \(asin(value))")
        
        return (2 * asin(value))
    }
    
    /**
     This draws the String str centred at the position
     specified by the polar coordinates (r, theta)
     i.e. the x= r * cos(theta) y= r * sin(theta)
     and rotated by the angle slantAngle
     */
    func centre(text str: String, context: CGContext, radius r:CGFloat, angle theta: CGFloat, slantAngle: CGFloat, pointColor:UIColor,isFirst:Bool,islast:Bool) {
        // Set the text attributes
        let textColor = self.textColor ?? .darkGray
        let textFont = self.font ?? UIFont.boldSystemFont(ofSize: CGFloat(24.0))
        let attributes : [NSAttributedString.Key : Any] = [.font : textFont,.foregroundColor : textColor] as [NSAttributedString.Key : Any]
        
        
        let flag:CGFloat = reverseAngle ? 1 : -1
        // Save the context
        context.saveGState()
        print("arif theta =\(theta)")
        print("arif cos(theta) =\(cos(theta))")
        print("arif sin(theta) =\(sin(theta))")
        
        let newX = r * cos(theta)
        let newY = flag*(r * sin(theta))
        
        let a = log(sliderValue)
        let value = sliderValue/exp(10)
        var Roffset:CGFloat = ((bounds.height)/2)*(a/10)
        
        if flag == 1{
            Roffset = Roffset*(-1)
        }
        
        // Move the origin to the centre of the text (negating the y-axis manually)
        
        let newYwitOffset = newY+Roffset
        if newX == CGFloat.nan || newYwitOffset == CGFloat.nan{
            context.restoreGState()
            return
        }
        
        
        if isFirst{
            let cirPath = UIBezierPath(arcCenter: CGPoint(x: newX-5.0, y: newYwitOffset-5.0), radius: 1.0, startAngle: 0.0, endAngle: .pi*2, clockwise: true)
            UIColor.blue.set()
            cirPath.lineWidth = 1.0
            cirPath.stroke()
        } else if islast{
            let cirPath = UIBezierPath(arcCenter: CGPoint(x: newX+5.0, y: newYwitOffset+5.0), radius: 1.0, startAngle: 0.0, endAngle: .pi*2, clockwise: true)
            UIColor.blue.set()
            cirPath.lineWidth = 1.0
            cirPath.stroke()
        }
        
        context.translateBy(x: newX, y: newYwitOffset)
        
        print("arif = \(newX)--\(newYwitOffset)")
        
        // Rotate the coordinate system
        context.rotate(by: flag*slantAngle)
        // Calculate the width of the text
        
        let offset = str.size(withAttributes: attributes)
        // Move the origin by half the size of the text
        context.translateBy(x: -offset.width / 2, y: -offset.height / 2) // Move the origin to the centre of the text (negating the y-axis manually)
        
        
        // Draw the text
        str.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
        
        
        let cirPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 1.0, startAngle: 0.0, endAngle: .pi*2, clockwise: true)
        pointColor.set()
        cirPath.lineWidth = 1.0
        cirPath.stroke()
        // Restore the context
        context.restoreGState()
    }
    
    func getRadiusForLabel() -> CGFloat? {
        
        let textFontSize = getTextSize()
        var diameter:CGFloat = ((textFontSize.width / (2 * .pi))*2)
        diameter += textFontSize.height*2
        
        
        // Imagine the bounds of this label will have a circle inside it.
        // The circle will be as big as the smallest width or height of this label.
        // But we need to fit the size of the font on the circle so make the circle a little
        // smaller so the text does not get drawn outside the bounds of the circle.
//        let smallestWidthOrHeight = min(self.bounds.size.height-curveLabelHeightOffset, self.bounds.size.width-curveLabelWidthOffset)
//        print("auny  -start-  ")
//        print("auny smallestWidthOrHeight = \(smallestWidthOrHeight)")
        
        
        let textSize = self.text?.size(withAttributes: [NSAttributedString.Key.font: self.font ?? UIFont.boldSystemFont(ofSize: CGFloat(10.0))])
        let heightOfFont = textSize!.height
        let widthOfFont = textSize!.width
        
        print("auny heightOfFont = \(widthOfFont)")
        
        // Dividing the smallestWidthOrHeight by 2 gives us the radius for the circle.
        
        var temp = (((diameter)/2) - (heightOfFont))
//        print("auny temp = \(temp)")
        
        if temp < 0.0{
            temp = 50
        }
//        if widthOfFont/2 < heightOfFont{
//            temp = (smallestWidthOrHeight/2)
//        }
        
        
//        print("auny sliderValue = \(sliderValue)")
        
        let value = temp + (sliderValue-1.0)
//
//        if widthOfFont/2 < heightOfFont{
//            if value < (smallestWidthOrHeight/2){
//                value = (smallestWidthOrHeight/2)
//            }
//        }
//        print("auny value = \(value)")
//
//        print("auny  -end-  ")
        
//        let roundValue = round(value)
//        let ans:CGFloat
//        if roundValue < sliderValue+heightOfFont{
//            ans = sliderValue
//        } else {
//            ans = value
//        }
//        print("value ans= \(ans)")
//        return ans
        
//        if Int(value) < 25{
//            value = 25.0
//        }
        return abs(value)
    }
    
    
    
    private func getTextSize()->CGSize{
        let newLabel = self
        let font =  (newLabel.font) ?? UIFont.boldSystemFont(ofSize: CGFloat(24.0))
        
        let kernvalue = fontSpace
        let attributedString = NSMutableAttributedString(string: newLabel.text ?? " ")
        attributedString.addAttribute(NSAttributedString.Key.kern,
                                      value: kernvalue,
                                      range: NSRange(location: 0, length: attributedString.length-1))
        
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attributedString.length))
        
        let size  = CGSize(width: attributedString.size().width+kernvalue, height: attributedString.size().height)
        
        return size
    }
    
    
    

}
