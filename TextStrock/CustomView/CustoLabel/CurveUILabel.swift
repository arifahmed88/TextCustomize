//
//  CurveUILabel.swift
//  TextStrock
//
//  Created by PosterMaker on 12/18/22.
//

import UIKit

@IBDesignable
class CurveUILabel: UILabel {
    var angle: CGFloat = (90)*(.pi/180)
    var clockwise: Bool = true
    var sliderValue:CGFloat = 1.0
    var fontSpace:CGFloat = 0.0
    var reverseAngle = false
    var circleDiameter = 0.0
    private var strokeColor = UIColor.systemBlue
    private var strokeWidth:CGFloat = 0.0
    private let sliderMaxValue:Float = 360.0
    
    override init(frame:CGRect){
        super.init(frame: frame)
        attributedTextInit(labelText: nil, textFont: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let value = 10 - log10(abs(sliderValue))
        if value < 6.0{
            super.draw(rect)
        } else {
            centreArcPerpendicular()
        }
        
    }
    
    
    func curveText(curveValue: CGFloat,fontspace:CGFloat,fontSize:CGFloat) {
        reverseAngle = curveValue >= 0 ? false : true
        let sliderValue:CGFloat = abs(CGFloat(sliderMaxValue) - abs(curveValue))
        let newValue:CGFloat = rangeConverter(value: Float(sliderValue), OldMin: 0, OldMax: Int(sliderMaxValue), NewMin: 0, NewMax: 100)/10
        let convertedValue = exp(newValue)
        let newConValue = ((convertedValue/30)*fontSize)
        self.sliderValue = newConValue
        fontSpace = fontspace
        labelWidthCalculation()
        setNeedsDisplay()
    }
    
    func attributedTextInit(labelText:String?,textFont:UIFont?){
        var newtext:String = " "
        if text != nil{
            newtext = text!
        }
        if labelText != nil{
            newtext = labelText!
        }
        
        var newfont = UIFont.boldSystemFont(ofSize: CGFloat(24.0))
        if font != nil{
            newfont = font!
        }
        if textFont != nil{
            newfont = textFont!
        }
        
        
        let kernValue = fontSpace*(font.pointSize)
        let attributedString = NSMutableAttributedString(string: newtext)
        attributedString.addAttribute(NSAttributedString.Key.kern,
                                      value: kernValue,
                                      range: NSRange(location: 0, length: attributedString.length-1))
        
        attributedString.addAttribute(NSAttributedString.Key.font, value: newfont, range: NSRange(location: 0, length: attributedString.length))
        
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length-1))
        self.attributedText = attributedString
    }
    
    
    private func getFontHeightWidthOffset()->(CGFloat,CGFloat){
        let textFontSize = getTextSize()
        var heightOffset = (15/40)*textFontSize.width
        var widthOffset = (15/53)*textFontSize.width
        
        if heightOffset < 30 {
            heightOffset = 30
        }
        
        if widthOffset < 30 {
            widthOffset = 30
        }
        
        return (heightOffset,widthOffset)
    }

    
    
    func labelWidthCalculation(){
        
        let textSize = getTextSize()
        //width calculation
        let s = textSize.width
        guard let r = getRadiusForLabel() else {
            return
        }
        let theta = s/r

        let p = (r*sin(theta/2))
        let resizedWidth = 2*p

        //height calculation
        let q = p/(tan(theta/2))
        let resizedHeight = r - q

        let factor = 1 - ((log(sliderValue))/10)

        let (curveLabelHeightOffset,curveLabelWidthOffset) = getFontHeightWidthOffset()
        let w = round(resizedWidth+curveLabelWidthOffset+(curveLabelWidthOffset*(factor)))
        let h = round(resizedHeight+(curveLabelHeightOffset))
        
        let previousCenter = CGPoint(x: self.center.x, y: self.center.y)
        self.frame.size.width = w
        self.frame.size.height = h
        self.center = previousCenter
        
    }
    
    func centreArcPerpendicular() {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.saveGState()
        let str = self.text ?? ""
        let size = self.bounds.size
        let flag:CGFloat = reverseAngle ? -1 : 1
        let point = CGPoint(x: size.width / 2, y: (size.height / 2)+((sliderValue)*flag))

        context.translateBy(x: point.x, y: point.y)
        guard let radius = getRadiusForLabel() else {
            return
        }
        
        let l = str.count
        let textColor = self.textColor ?? .darkGray
        let textFont = self.font ?? UIFont.boldSystemFont(ofSize: CGFloat(24.0))
        let attributes : [NSAttributedString.Key : Any] = [.font : textFont,.foregroundColor : textColor]
        let characters: [String] = str.map { String($0) }
        var arcs: [CGFloat] = []
        var totalArc: CGFloat = 0
        for i in 0 ..< l {
            arcs += [chordToArc(characters[i].size(withAttributes: attributes).width+(fontSpace*font.pointSize), radius: radius)]
            totalArc += arcs[i]
        }
        
        let direction: CGFloat = clockwise ? -1 : 1
        let slantCorrection = clockwise ? -CGFloat(Double.pi/2) : CGFloat(Double.pi/2)
        
        
        //stroke draw
        var thetaI = angle - direction * totalArc / 2
        for i in 0 ..< l {
            thetaI += direction * arcs[i] / 2
            centreforStroke(text: characters[i], context: context, radius: radius, angle: thetaI, slantAngle: thetaI + slantCorrection)
            thetaI += direction * arcs[i] / 2
        }
        

        //text draw
        thetaI = angle - direction * totalArc / 2
        for i in 0 ..< l {
            thetaI += direction * arcs[i] / 2
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
            thetaI += direction * arcs[i] / 2
        }
    }
    
    func chordToArc(_ chord: CGFloat, radius: CGFloat) -> CGFloat {
        var value = chord / (2 * radius)
        if value < -1.0{
            value = -1.0
        } else if value > 1.0{
            value = 1.0
        }
        return (2 * asin(value))
    }
    
    /**
     This draws the String str centred at the position
     specified by the polar coordinates (r, theta)
     i.e. the x= r * cos(theta) y= r * sin(theta)
     and rotated by the angle slantAngle
     */
    func centre(text str: String, context: CGContext, radius r:CGFloat, angle theta: CGFloat, slantAngle: CGFloat, pointColor:UIColor,isFirst:Bool,islast:Bool) {

        
        let textColor = self.textColor ?? .darkGray
        let textFont = self.font ?? UIFont.boldSystemFont(ofSize: CGFloat(24.0))
        let attributes : [NSAttributedString.Key : Any] = [.font : textFont,.foregroundColor : textColor] as [NSAttributedString.Key : Any]
        
        let flag:CGFloat = reverseAngle ? 1 : -1
        context.saveGState()
        let newX = r * cos(theta)
        let newY = flag*(r * sin(theta))
        
        let normalizedvalue = log(sliderValue)

        var Roffset:CGFloat = ((bounds.height)/2)*(normalizedvalue/10)
        
        if flag == 1{
            Roffset = Roffset*(-1)
        }
        
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
        context.rotate(by: flag*slantAngle)
        let offset = str.size(withAttributes: attributes)
        context.translateBy(x: -offset.width / 2, y: -offset.height / 2)
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        //context.setBlendMode(.clear)
        context.setTextDrawingMode(.fill)
        str.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
        
        
        let cirPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 1.0, startAngle: 0.0, endAngle: .pi*2, clockwise: true)
        pointColor.set()
        cirPath.lineWidth = 1.0
        cirPath.stroke()
        context.restoreGState()
    }
    
    
   func centreforStroke(text str: String, context: CGContext, radius r:CGFloat, angle theta: CGFloat, slantAngle: CGFloat) {

       let textColor = self.textColor ?? .darkGray
       let textFont = self.font ?? UIFont.boldSystemFont(ofSize: CGFloat(24.0))
       let attributes : [NSAttributedString.Key : Any] = [.font : textFont,.foregroundColor : textColor] as [NSAttributedString.Key : Any]
       
       let stockAttributes : [NSAttributedString.Key : Any] = [.font : textFont,.foregroundColor : strokeColor] as [NSAttributedString.Key : Any]

       let flag:CGFloat = reverseAngle ? 1 : -1
       context.saveGState()
       let newX = r * cos(theta)
       let newY = flag*(r * sin(theta))
       
       let normalizeValue = log(sliderValue)
       var Roffset:CGFloat = ((bounds.height)/2)*(normalizeValue/10)
       
       if flag == 1{
           Roffset = Roffset*(-1)
       }
              
       let newYwitOffset = newY+Roffset
       if newX == CGFloat.nan || newYwitOffset == CGFloat.nan{
           context.restoreGState()
           return
       }
       
       
       context.translateBy(x: newX, y: newYwitOffset)
       context.rotate(by: flag*slantAngle)
       
       let offset = str.size(withAttributes: attributes)
       context.translateBy(x: -offset.width / 2, y: -offset.height / 2)
      
       guard let context = UIGraphicsGetCurrentContext() else {return}
       let strokeSize = self.font.pointSize*strokeWidth
       context.setLineWidth(strokeSize)
       context.setLineJoin(.round)
       context.setTextDrawingMode(.stroke)
       str.draw(at: CGPoint(x: 0, y: 0), withAttributes: stockAttributes)
       context.restoreGState()
   }
    
    func getRadiusForLabel() -> CGFloat? {
        let textFontSize = getTextSize()
        var diameter:CGFloat = ((textFontSize.width / (2 * .pi))*2)
        diameter += textFontSize.height*2

        var temp = (((diameter)/2) - (textFontSize.height))
        if temp < 0.0{
            temp = 50
        }
        let value = temp + (sliderValue-1.0)
        return abs(value)
    }
    
    
    
    private func getTextSize()->CGSize{
        let newLabel = self
        let font = (newLabel.font) ?? UIFont.boldSystemFont(ofSize: CGFloat(24.0))
        
        let kernvalue = (fontSpace)*font.pointSize
        let attributedString = NSMutableAttributedString(string: newLabel.text ?? " ")
        attributedString.addAttribute(NSAttributedString.Key.kern,
                                      value: kernvalue,
                                      range: NSRange(location: 0, length: attributedString.length-1))
        
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attributedString.length))
        
        let size  = CGSize(width: attributedString.size().width+kernvalue, height: attributedString.size().height)
        
        return size
    }
    
    private func rangeConverter(value:Float,OldMin:Int,OldMax:Int,NewMin:Int,NewMax:Int) -> CGFloat {
       let OldValue = Int(value)
       let NewValue = (((OldValue - OldMin) * (NewMax - NewMin)) / (OldMax - OldMin)) + NewMin
       return CGFloat(NewValue)
    }
}


extension CurveUILabel{
    func textColorChange(color:UIColor){
        self.textColor = color
        self.setNeedsDisplay()
    }
    
    func textGradientColorChange(color:GradientColor){
        self.textColor = color.getGradientUIColor(in: self.bounds) ?? UIColor.black
        self.setNeedsDisplay()
    }
    
    
    func strokeColorChange(color:UIColor){
        self.strokeColor = color
        self.setNeedsDisplay()
    }
    
    func strokeGradientColorChange(color:GradientColor){
        self.strokeColor = color.getGradientUIColor(in: self.bounds) ?? UIColor.red
        self.setNeedsDisplay()
    }
    
    func strokeWidthChange(value:CGFloat){
        self.strokeWidth = value
        self.setNeedsDisplay()
    }
}
