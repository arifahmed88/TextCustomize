//
//  MagnifyingGlassView.swift
//  TextStrock
//
//  Created by PosterMaker on 1/25/23.
//

import UIKit

public class MagnifyingGlassView: UIView {
    
    public var scale: CGFloat = 3.0
    public var borderColor: UIColor = UIColor.white
    public var borderWidth: CGFloat = 0.3
    public var offset: CGPoint = CGPoint.zero
    
    public var centerCircelLayerLineWidth: CGFloat = 1.3
    public var centerCircelLayerRadius: CGFloat = 4.0
    
    public var innerCircelLayerLineWidth: CGFloat = 0.1
    public var innerCircelLayerStrockColor = UIColor(red: 135/255, green: 135/255, blue: 135/255, alpha: 1.0)
    
    private let centerCircelLayer: CAShapeLayer = CAShapeLayer()
    private let middleCircelLayer: CAShapeLayer = CAShapeLayer()
    private let innerCircelLayer: CAShapeLayer = CAShapeLayer()
    
    
    
    public var radius: CGFloat = 60.0 {
        didSet {
            frame = CGRect(origin: frame.origin, size: CGSize(width: radius * 2, height: radius * 2))
            layer.cornerRadius = radius
            centerCircelLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.width*0.5, y: bounds.width*0.5), radius: centerCircelLayerRadius, startAngle: 0.0, endAngle: .pi*2, clockwise: true).cgPath
            middleCircelLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.width*0.5, y: bounds.width*0.5), radius: radius-5, startAngle: 0.0, endAngle: .pi*2, clockwise: true).cgPath
            innerCircelLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.width*0.5, y: bounds.width*0.5), radius: radius-10, startAngle: 0.0, endAngle: .pi*2, clockwise: true).cgPath
            
            
        }
    }
    

    public weak var magnifiedView: UIView? {
        didSet {
            removeFromSuperview()
            magnifiedView?.addSubview(self)
        }
    }

    public var magnifiedPoint: CGPoint = CGPoint.zero {
        didSet {
            center = CGPoint(x: magnifiedPoint.x + offset.x, y: magnifiedPoint.y + offset.y)
        }
    }
    

    public convenience init(offset: CGPoint = CGPoint.zero,
                            radius: CGFloat = 50.0,
                            scale: CGFloat = 4.0) {
        self.init(frame: CGRect.zero)

        addMiddleCircelLayer()
        addCenterCircelLayer()
        addInnerCircelLayer()
        addBorder()
        
        defer {
            self.offset = offset
            self.radius = radius
            self.scale = scale
        }
    }
    
    private func addBorder(){
        layer.masksToBounds = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
    
    private func addInnerCircelLayer(){
        innerCircelLayer.strokeColor = innerCircelLayerStrockColor.cgColor
        innerCircelLayer.fillColor = UIColor.clear.cgColor
        innerCircelLayer.lineWidth = innerCircelLayerLineWidth
        layer.addSublayer(innerCircelLayer)
    }
    
    private func addMiddleCircelLayer(){
        middleCircelLayer.strokeColor = UIColor(red: 192/255, green: 149/255, blue: 128/255, alpha: 1.0).cgColor
        middleCircelLayer.fillColor = UIColor.clear.cgColor
        middleCircelLayer.lineWidth = 10.0
        layer.addSublayer(middleCircelLayer)
    }
    
    private func addCenterCircelLayer(){
        centerCircelLayer.strokeColor = UIColor.white.cgColor
        centerCircelLayer.fillColor = UIColor.clear.cgColor
        centerCircelLayer.lineWidth = centerCircelLayerLineWidth
        layer.addSublayer(centerCircelLayer)
    }
    
    public func magnify(at point: CGPoint) {
        guard magnifiedView != nil else { return }

        magnifiedPoint = point
        layer.setNeedsDisplay()
    }
    
    /// Creates crosshair path for given radius
    private func crosshairPath(for radius: CGFloat) -> CGPath {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: radius, y: 0.0))
        path.addLine(to: CGPoint(x: radius, y: bounds.height))
        path.move(to: CGPoint(x: 0.0, y: radius))
        path.addLine(to: CGPoint(x: bounds.width, y: radius))
        return path
    }

    /// Renders magnification glass
    public override func draw(_ rect: CGRect) {
        //super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.translateBy(x: radius, y: radius)
        context.scaleBy(x: scale, y: scale)
        context.translateBy(x: -magnifiedPoint.x, y: -magnifiedPoint.y)

        removeFromSuperview()
        magnifiedView?.layer.render(in: context)
        magnifiedView?.addSubview(self)
        
        if let pointColor = magnifiedView?.layer.colorOfPoint(point: self.center){
            middleCircelLayer.strokeColor = pointColor.cgColor
        }
    }

}


extension CALayer {
    func colorOfPoint(point: CGPoint) -> UIColor? {
        /// Our pixel data
        var pixel: [UInt8] = [0, 0, 0, 0]
        /// The device's color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        /// Get the pixel data already multiplied by the alpha value
        let bitmapInfo = CGBitmapInfo(
            rawValue: CGImageAlphaInfo.premultipliedLast.rawValue
        )
        
        /// try to get a context of 1x1 pixel by getting 8 bits
        /// per component in the given color space
        guard let context = CGContext(
            data: &pixel,
            width: 1,
            height: 1,
            bitsPerComponent: 8,
            bytesPerRow: 4,
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue
        ) else { return nil }
        context.translateBy(x: -point.x, y: -point.y)
        
        render(in: context)
        /// Get every value from the array
        let red = CGFloat(pixel[0]) / 255.0
        let green = CGFloat(pixel[1]) / 255.0
        let blue = CGFloat(pixel[2]) / 255.0
        let alpha = CGFloat(pixel[3]) / 255.0
        
        /// Create the color from the values
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
