//
//  UIGradientColorList.swift
//  TextStrock
//
//  Created by PosterMaker on 11/29/22.
//

import UIKit

enum GradientColorPosition:String{
    case top = "Top"
    case bottom = "Bottom"
    case left = "Left"
    case right = "Right"
    case topLeft = "TopLeft"
    case topRight = "TopRight"
    case bottomLeft = "BottomLeft"
    case bottomRight = "BottomRight"
}


class GradientColor{
    
    var gradientColors: [CGColor] = []
    var firstColor:UIColor
    var secondColor:UIColor
    var angel:CGFloat = 0.0
    
    init(firstColor: UIColor, secondColor: UIColor) {
        self.firstColor = firstColor
        self.secondColor = secondColor
        
        gradientColors.append(firstColor.cgColor)
        gradientColors.append(secondColor.cgColor)
    }
    
    
    func getGradientUIColor(in rect: CGRect,angle:CGFloat = 0.0) -> UIColor? {
       
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = rect
        
        let color1 = firstColor.cgColor
        let color2 = secondColor.cgColor
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.2, 0.8]

        
        
        let point = getGradientStartAndEndPoint(angle: angle)
        gradientLayer.startPoint = point.0
        gradientLayer.endPoint = point.1
        
        let image = imageFromLayer(layer: gradientLayer)
        
        return UIColor(patternImage: image)
    }
    
    
    
    func getGradientStartAndEndPoint(angle: CGFloat) ->(CGPoint,CGPoint) {
        
        let radius:CGFloat = 0.5
        let center = CGPoint(x: 0.5, y: 0.5)

        //start point
        let startAngle:CGFloat = (.pi/180)*angle
        let sX = center.x + radius*sin(startAngle)
        let sY = center.y - radius*cos(startAngle)

        let startPoint = CGPoint(x: sX, y: sY)

        //end Point
        let endAngle:CGFloat = (.pi/180)*(angle+180)
        let eX = center.x + radius*sin(endAngle)
        let eY = center.y - radius*cos(endAngle)

        let endPoint = CGPoint(x: eX, y: eY)
        return (startPoint,endPoint)

    }
    
    
    
    
//
//    func getGradientUIColor(in rect: CGRect,angle:CGFloat = 0.0) -> UIColor? {
//        let currentContext = UIGraphicsGetCurrentContext()
//        currentContext?.saveGState()
//        defer { currentContext?.restoreGState() }
//
//        let size = rect.size
//        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
//                                        colors: gradientColors as CFArray,
//                                        locations: nil) else { return nil }
//
//        let context = UIGraphicsGetCurrentContext()
//
//        //let tempX = (size.width*(angle/100))
//        let sPoint:CGPoint
//        let ePoint:CGPoint
////        if angle == 0.0||angle == 360.0{
////            sPoint = .zero
////            ePoint = CGPoint(x: 0, y: size.height)
////        }
////        else {
//            let point = getGradientStartAndEndPoint(size: size, angle: angle)
//            sPoint = point.0
//            ePoint = point.1
//        //}
//
//
////    context?.drawLinearGradient(gradient,start: sPoint,end: ePoint,options: [.drawsAfterEndLocation])
//
//        let value = rangeConverter(value: Float(angle), OldMin: 0, OldMax: 360, NewMin: 0, NewMax: 100)
//        let percent = value/100
//
//        let endRaidus:CGFloat = size.width
//
//        context?.drawRadialGradient(gradient,
//                                    startCenter: CGPoint(x: size.width/2.0, y: 0),
//                                    startRadius: 0,
//                                    endCenter:  CGPoint(x: size.width/2.0, y: size.height),
//                                    endRadius: endRaidus, options: [.drawsAfterEndLocation])
//
//        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        guard let image = gradientImage else { return nil }
//        return UIColor(patternImage: image)
//    }
    
//
//    func getGradientStartAndEndPoint(size:CGSize, angle: CGFloat) ->(CGPoint,CGPoint) {
//        let radius = sqrt(size.width*size.width+size.height*size.height)
////        let radius = max(size.width, size.height)
//        let center = CGPoint(x: size.width*0.5, y: size.height*0.5)
//
//        //start point
//        let startAngle:CGFloat = (.pi/180)*angle
//        let sX = center.x + radius*sin(startAngle)
//        let sY = center.y - radius*cos(startAngle)
//
//        let startPoint = CGPoint(x: sX, y: sY)
//
//        //end Point
//        let endAngle:CGFloat = (.pi/180)*(angle+180)
//        let eX = center.x + radius*sin(endAngle)
//        let eY = center.y - radius*cos(endAngle)
//
//        let endPoint = CGPoint(x: eX, y: eY)
//        return (startPoint,endPoint)
//
//        //if angel <= 0.0 || angel >= 90.0{
//
////        let value = rangeConverter(value: Float(angle), OldMin: 0, OldMax: 360, NewMin: 0, NewMax: 100)
////        let percent = value/100
////
////        let sY:CGFloat = (-size.height)+(size.height*percent)
////        let startP = CGPoint(x: 0, y: )
////
////
////
////        let eX:CGFloat = (size.width*percent)
////        print("size = \(size.width) \(eX) \(percent)")
////        let endP = CGPoint(x: eX, y: size.height*2)
////
////            return  (startP,endP)
////
////        } else  {
////            return (CGPoint(x: 0, y: 0),CGPoint(x: 0, y: size.height))
////        }
//
//    }
    
    
    
    
//    private func getGPositionStartEndPoint(size:CGSize,position:GradientColorPosition)->(CGPoint,CGPoint){
//        
//        var startPoint = CGPoint(x: 0, y: 0)
//        var endPoint = CGPoint(x: 0, y: 0)
//        
//        switch position{
//        case .left:
//            startPoint = CGPoint.zero
//            endPoint = CGPoint(x: size.width, y: 0)
//            break
//        case .right:
//            startPoint = CGPoint(x: size.width, y: 0)
//            endPoint = CGPoint.zero
//            break
//        case .top:
//            startPoint = CGPoint.zero
//            endPoint = CGPoint(x: 0, y: size.height)
//            break
//        case .bottom:
//            startPoint = CGPoint(x: 0, y: size.height)
//            endPoint = CGPoint.zero
//            break
//        case .topLeft:
//            startPoint = CGPoint.zero
//            endPoint = CGPoint(x: size.width, y: size.height)
//            break
//        case .topRight:
//            startPoint = CGPoint(x: size.width, y: 0)
//            endPoint = CGPoint(x: 0, y: size.height)
//            break
//        case .bottomLeft:
//            startPoint =
//            endPoint =
//            break
//        case .bottomRight:
//            startPoint = CGPoint(x: size.width, y: size.height)
//            endPoint = CGPoint.zero
//            break
//            
//        }
//    }
    
//    func rangeConverter(value:CGFloat) -> CGFloat {
//        let OldValue = Int(value*100)
//        let OldMin = 0
//        let OldMax = 360
//        let NewMin = 0
//        let NewMax = 100
//        let NewValue = (((OldValue - OldMin) * (NewMax - NewMin)) / (OldMax - OldMin)) + NewMin
//        return CGFloat(NewValue)
//    }
    
    private func rangeConverter(value:Float,OldMin:Int,OldMax:Int,NewMin:Int,NewMax:Int) -> CGFloat {
        let OldValue = Int(value)
        let NewValue = (((OldValue - OldMin) * (NewMax - NewMin)) / (OldMax - OldMin)) + NewMin
        return CGFloat(NewValue)
    }
    
    func imageFromLayer(layer:CAGradientLayer) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.isOpaque, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
    
}

class UIGradientColorList{
    
    var uiGradentColorList:[GradientColor] = []
    
    private var firstColorNameList:[String] = ["#9C254D","#540375","#FFBF00","#3F0071","#F2E5E5","#FED049","#CFFDE1","#2A3990","#65647C","#0014FF","#3B185F","#285430","#557153","#8EC3B0","#6C4AB6","#FFE1E1","#E14D2A","#FF8DC7","#FF97C1","#E0144C"]
    private var SecondColorNameList:[String] = ["#285430","#FF7000","#10A19D","#FB2576","#CE7777","#CFFDE1","#150050","#F06292","#FF731D","#00FFF6","#C060A1","#E5D9B6","#557153","#DEF5E5","#B9E0FF","#90A17D","#001253","#FFB9B9","#9A1663","#FF5858"]
    
    
    init(){
        setupColorList()
    }
    
    private func setupColorList(){
        
        for (index,firstColor) in firstColorNameList.enumerated() {
            let firstUIColor = UIColor.hexStringToUIColor(hex: firstColor)
            let secondUIColor = UIColor.hexStringToUIColor(hex: SecondColorNameList[index])
            let gradientColor = GradientColor(firstColor: firstUIColor, secondColor: secondUIColor)
            uiGradentColorList.append(gradientColor)
        }
    }
    
}

