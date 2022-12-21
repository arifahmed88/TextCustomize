//
//  CurveUILabel.swift
//  TextStrock
//
//  Created by PosterMaker on 12/18/22.
//

import UIKit

@IBDesignable
class CurveUILabel: UILabel {
    
    @IBInspectable var angle: CGFloat = 1.5708
    @IBInspectable var clockwise: Bool = true
    
    var sliderValue:CGFloat = 0.0
    
    var inflection:CGFloat = 0.0
    
    override func drawText(in rect: CGRect) {

        let text = self.text ?? "arif"
//        drawTextImageTemp(text: text, inflection: self.inflection, size: rect.size)
        centreArcPerpendicular()

    }
    
    
//    override func draw(_ rect: CGRect) {
////        centreArcPerpendicular()
//
////        let text = self.text ?? "arif"
////        let nsText = text as NSString
////        let attributes = [
////            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24),
////            NSAttributedString.Key.foregroundColor: UIColor.red
////        ]
////        nsText.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
//
////        let size =
//        drawTextImageTemp(text: text, inflection: 100.0, size: rect.size)
//    }
//
    /**
     This draws the self.text around an arc of radius r,
     with the text centred at polar angle theta
     */
    func centreArcPerpendicular() {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let str = self.text ?? ""
        let size = self.bounds.size
        ///size.width = size.width
        context.translateBy(x: size.width / 2, y: (size.height / 2)+sliderValue)
        
        let radius = getRadiusForLabel()
        let l = str.count
        let attributes : [NSAttributedString.Key : Any] = [.font : self.font ?? UIFont.boldSystemFont(ofSize: CGFloat(24.0)),.foregroundColor : UIColor.systemRed]
        
        let characters: [String] = str.map { String($0) } // An array of single character strings, each character in str
        var arcs: [CGFloat] = [] // This will be the arcs subtended by each character
        var totalArc: CGFloat = 0 // ... and the total arc subtended by the string
        
        // Calculate the arc subtended by each letter and their total
        for i in 0 ..< l {
            //            arcs = [chordToArc(characters[i].widthOfString(usingFont: self.font), radius: radius)]
            arcs += [chordToArc(characters[i].size(withAttributes: attributes).width, radius: radius)]
            totalArc += arcs[i]
        }
        
        // Are we writing clockwise (right way up at 12 o'clock, upside down at 6 o'clock)
        // or anti-clockwise (right way up at 6 o'clock)?
        let direction: CGFloat = clockwise ? -1 : 1
        let slantCorrection = clockwise ? -CGFloat(Double.pi/2) : CGFloat(Double.pi/2)
        
        // The centre of the first character will then be at
        // thetaI = theta - totalArc / 2 + arcs[0] / 2
        // But we add the last term inside the loop
        var thetaI = angle - direction * totalArc / 2
        
        for i in 0 ..< l {
            thetaI += direction * arcs[i] / 2
            // Call centre with each character in turn.
            // Remember to add +/-90º to the slantAngle otherwise
            // the characters will "stack" round the arc rather than "text flow"
            centre(text: characters[i], context: context, radius: radius, angle: thetaI, slantAngle: thetaI + slantCorrection)
            // The centre of the next character will then be at
            // thetaI = thetaI + arcs[i] / 2 + arcs[i + 1] / 2
            // but again we leave the last term to the start of the next loop...
            thetaI += direction * arcs[i] / 2
        }
    }
    
    func chordToArc(_ chord: CGFloat, radius: CGFloat) -> CGFloat {
        // *******************************************************
        // Simple geometry
        // *******************************************************
        return 2 * asin(chord / (2 * radius))
    }
    
    /**
     This draws the String str centred at the position
     specified by the polar coordinates (r, theta)
     i.e. the x= r * cos(theta) y= r * sin(theta)
     and rotated by the angle slantAngle
     */
    func centre(text str: String, context: CGContext, radius r:CGFloat, angle theta: CGFloat, slantAngle: CGFloat) {
        // Set the text attributes
        let attributes = [NSAttributedString.Key.font: self.font!,.foregroundColor:UIColor.red] as [NSAttributedString.Key : Any]
        // Save the context
        context.saveGState()
        // Move the origin to the centre of the text (negating the y-axis manually)
        context.translateBy(x: r * cos(theta), y: -(r * sin(theta)))
        // Rotate the coordinate system
        context.rotate(by: -slantAngle)
        // Calculate the width of the text
        let offset = str.size(withAttributes: attributes)
        // Move the origin by half the size of the text
        context.translateBy(x: -offset.width / 2, y: -offset.height / 2) // Move the origin to the centre of the text (negating the y-axis manually)
        // Draw the text
        str.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
        // Restore the context
        context.restoreGState()
    }
    
    func getRadiusForLabel() -> CGFloat {
        // Imagine the bounds of this label will have a circle inside it.
        // The circle will be as big as the smallest width or height of this label.
        // But we need to fit the size of the font on the circle so make the circle a little
        // smaller so the text does not get drawn outside the bounds of the circle.
        let smallestWidthOrHeight = min(self.bounds.size.height, self.bounds.size.width)
        let heightOfFont = self.text?.size(withAttributes: [NSAttributedString.Key.font: self.font ?? UIFont.boldSystemFont(ofSize: CGFloat(24.0))]).height ?? 0
        
        // Dividing the smallestWidthOrHeight by 2 gives us the radius for the circle.
        let value = ((smallestWidthOrHeight/2) - heightOfFont + 5)+sliderValue
        print("value = \(value)")
        return value
    }
    
    
    
    
    
    
    
    
    
    ///
    ///
    ///
    ///

    // `c1` is the first side of the triangle
    // `c2` is the second side
    // The function returns the hypotenuse
    fileprivate func radius(c1: CGFloat, c2: CGFloat) -> CGFloat {
      return sqrt(pow(c1, 2) + pow(c2, 2))
    }

    // `x` is the x-coordinate of the letter
    // `r` is the radius of the circle over which we want to draw the text
    // The function returns the y-coordinate
    fileprivate func halfCircle(x: CGFloat, r: CGFloat) -> CGFloat {
      // r^2 = x^2 + y^2
      // r^2 - x^2 = y^2
      // y = sqrt(r^2 - x^2)
      return sqrt(pow(r, 2)-pow(x, 2))
    }
    
//    func drawTextImage(text: String, inflection: CGFloat, size: CGSize) -> UIImage {
//      // Create a format for the renderer to set the scale to 1
//      let format = UIGraphicsImageRendererFormat()
//      format.scale = 1
//
//      // Create the renderer
//      let renderer = UIGraphicsImageRenderer(size: size, format: format)
//
//      // Ask the renderer to create an image
//      let image = renderer.image { rendererContext in
//        let context = rendererContext.cgContext
//
//        // Split the string in characters and convert them to NSString so
//        // we can leverage .size and .draw method
//        let chars = text.map { String($0) as NSString }
//        let nsText = text as NSString
//
//          let attributes = [
//          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 72),
//          NSAttributedString.Key.foregroundColor: UIColor.red
//        ]
//
//        // Compute the size of the text. We need the width to compute the radius of the circle
//        let textSize = nsText.size(withAttributes: attributes)
//
//        // Get the center of the space where we need to draw the text
//        let center = CGPoint(
//          x: (size.width - textSize.width) / 2,
//          y: (size.height - textSize.height) / 2
//        )
//
//        // Handle the edge case where we don't want a curved text. Just draw the nsText
//        guard inflection != 0 else {
//          nsText.draw(at: center, withAttributes: attributes)
//          return
//        }
//
//        // Create a variable that works as accumulator to draw the single letters
//        var startPoint = center
//
//        // Compute the second side of the triangle. It depends on how curved we want the text.
//        let c2 = abs(inflection * textSize.width / 2)
//
//        // Compute the radius of the circumference
//        let r = radius(c1: textSize.width / 2, c2: c2)
//
//        // Start drawinf the single characters
//        for c in chars {
//          // Save the current state of the context
//          context.saveGState()
//
//          // Compute the size of the letter to draw
//          let cSize = c.size(withAttributes: attributes)
//
//          // Compute the leftmost x-coordinate of the letter.
//          // we need to subtract half of the text width to make sure that the center
//          // is in the same x-coordinate of the center of the text we want to draw
//          let x = (startPoint.x - center.x) - textSize.width/2
//          // Compute the y-coordinate. It is multiplied by the inflection to ensure a smooth behavior
//          let y = inflection * halfCircle(x: x, r: r)
//
//          // Compute the mid point of the letter, we need this to position the context
//          // correctly before drawing the letter
//          let xm = (startPoint.x + cSize.width/2 - center.x) - textSize.width / 2
//          let ym = inflection * halfCircle(x: xm, r: r)
//
//          // Compute the rightmost point of the letter
//          let x2 = ((startPoint.x + cSize.width) - center.x) - textSize.width / 2
//          let y2 = inflection * halfCircle(x: x2, r: r)
//
//          // Compute the slope and the rotation
//          let m = (y2 - y) / (x2 - x)
//          let theta: CGFloat = atan(m)
//
//          // Compute the y position for the letter.
//          // from the center of the screen, we need to move by the `ym` value of the letter
//          // and we need to subtract how much we moved the center of the circumference.
//          // If we do not add the `- inflection * c2`, we are basically keeping the
//          // center of the circle in the center of our paper. Therefore, the text will move
//          // up or down. Instead, we want to keep it in the middle of the view.
//          startPoint.y = center.y + ym - inflection * c2
//
//          // First, lets move the context so that it is centered in the letter.
//          context.translateBy(
//            x: startPoint.x + cSize.width/2,
//            y: startPoint.y + cSize.height/2
//          )
//
//          // Rotate the paper around the center of the letter
//          context.rotate(by: theta)
//
//          // Draw the letter. We need to draw the letter at `(-cSize.width/2, -cSize.height/2)` because
//          // CoreGraphics draws the letter from their top left corner.
//          c.draw(
//            at: .init(
//              x: -cSize.width/2,
//              y: -cSize.height/2
//            ),
//            withAttributes: attributes)
//
//          // Update the accumulator so that we move on the x axis to render the next letter.
//          startPoint.x = startPoint.x + cSize.width
//
//          // Restore the context
//          context.restoreGState()
//        }
//      }
//      return image
//    }
    
    
    
    
    func drawTextImageTemp(text: String, inflection: CGFloat, size: CGSize) {
        
        let newSize = size
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Split the string in characters and convert them to NSString so
        // we can leverage .size and .draw method
        let chars = text.map { String($0) as NSString }
        let nsText = text as NSString
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.strokeWidth : -1.0,
            NSAttributedString.Key.foregroundColor: UIColor.systemMint,
            
        ] as [NSAttributedString.Key : Any]
        
        // Compute the size of the text. We need the width to compute the radius of the circle
        let textSize = nsText.size(withAttributes: attributes)
        
        // Get the center of the space where we need to draw the text
        let center = CGPoint(
            x: (newSize.width - textSize.width) / 2,
            y: (newSize.height - textSize.height) / 2
        )
        
        // Handle the edge case where we don't want a curved text. Just draw the nsText
        guard inflection != 0 else {
            nsText.draw(at: center, withAttributes: attributes)
            return
        }
        
        // Create a variable that works as accumulator to draw the single letters
        var startPoint = center
        
        // Compute the second side of the triangle. It depends on how curved we want the text.
        let c2 = abs(inflection * (textSize.width / 2))
        
        // Compute the radius of the circumference
        let r = radius(c1: textSize.width / 2, c2: c2)
        
        // Start drawinf the single characters
        for c in chars {
            // Save the current state of the context
            context.saveGState()
            
            // Compute the size of the letter to draw
            let cSize = c.size(withAttributes: attributes)
            
            // Compute the leftmost x-coordinate of the letter.
            // we need to subtract half of the text width to make sure that the center
            // is in the same x-coordinate of the center of the text we want to draw
            let x = (startPoint.x - center.x) - textSize.width/2
            // Compute the y-coordinate. It is multiplied by the inflection to ensure a smooth behavior
            let y = inflection * halfCircle(x: x, r: r)
            
            // Compute the mid point of the letter, we need this to position the context
            // correctly before drawing the letter
            let xm = (startPoint.x + cSize.width/2 - center.x) - textSize.width / 2
            let ym = inflection * halfCircle(x: xm, r: r)
            
            // Compute the rightmost point of the letter
            let x2 = ((startPoint.x + cSize.width) - center.x) - textSize.width / 2
            let y2 = inflection * halfCircle(x: x2, r: r)
            
            // Compute the slope and the rotation
            let m = (y2 - y) / (x2 - x)
            let theta: CGFloat = atan(m)
            
            // Compute the y position for the letter.
            // from the center of the screen, we need to move by the `ym` value of the letter
            // and we need to subtract how much we moved the center of the circumference.
            // If we do not add the `- inflection * c2`, we are basically keeping the
            // center of the circle in the center of our paper. Therefore, the text will move
            // up or down. Instead, we want to keep it in the middle of the view.
            startPoint.y = center.y + ym - inflection * c2
            
            // First, lets move the context so that it is centered in the letter.
            context.translateBy(
                x: startPoint.x + cSize.width/2,
                y: startPoint.y + cSize.height/2
            )
            
            // Rotate the paper around the center of the letter
            context.rotate(by: theta)
            
            // Draw the letter. We need to draw the letter at `(-cSize.width/2, -cSize.height/2)` because
            // CoreGraphics draws the letter from their top left corner.
            c.draw(
                at: .init(
                    x: -cSize.width/2,
                    y: -cSize.height/2
                ),
                withAttributes: attributes)
            //c.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
            
            // Update the accumulator so that we move on the x axis to render the next letter.
            startPoint.x = startPoint.x + cSize.width
            
            // Restore the context
            context.restoreGState()
        }
        
        
    }

    
    
    
    
    
    
    
}
