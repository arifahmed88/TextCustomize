//
//  TextCurveViewController.swift
//  TextStrock
//
//  Created by PosterMaker on 12/18/22.
//

import UIKit
import SnapKit


class TextCurveViewController: UIViewController {
    @IBOutlet weak var label: CurveUILabel!
    
    let testLabel = CurveUILabel()
    let curveLabel = DGCurvedLabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    let testview = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    var testCAlayer:CALayer = CALayer()
    
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    let sliderValue:Float = 0.0
    let sliderMinValue:Float = -200.0
    let sliderMaxValue:Float = 200.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testLabel.textAlignment = .center
        view.addSubview(testLabel)
        
        
        //
//        curveLabel.text = "arif ahmed auny"
//        curveLabel.font = UIFont(name: "Chalkduster", size: 24)
//        curveLabel.textColor = UIColor.systemPink
//
////        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.blue,.font: UIFont(name: "Chalkduster", size: 24) ?? UIFont.boldSystemFont(ofSize: CGFloat(24))]
////        curveLabel.attributedText = NSMutableAttributedString(string: "arif ahmed auny", attributes: attributes)
//        curveLabel.textInside = false
//        curveLabel.radius = 100
//
//        curveLabel.backgroundColor = .lightGray
//        curveLabel.sizeToFit()
//        view.addSubview(curveLabel)
//        curveLabel.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        
        slider.value = sliderValue
        slider.minimumValue = sliderMinValue
        slider.maximumValue = sliderMaxValue
        
        sliderLabel.text = "\(Int(sliderValue))"
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let originX:CGFloat = 20
        let originY:CGFloat = 200
        
        testLabel.frame = CGRect(origin: CGPoint(x: originX, y: originY), size: CGSize(width: UIScreen.main.bounds.width - 2*originX, height: 200.0))
        testLabel.backgroundColor = UIColor.hexStringToUIColor(hex: "#EEEEEE")
        testLabel.textColor = .systemBlue
        testLabel.text = "This of the CurveText. are iu i am"
//        testLabel.isHidden = true
        
        
        //test
//        curveLabel.frame = CGRect(origin: CGPoint(x: originX, y: originY), size: CGSize(width: UIScreen.main.bounds.width - 2*originX, height: 600.0))
//        curveLabel.center = CGPoint(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height*0.5)
        
//        testview.backgroundColor = .systemMint
//
//        testview.center = CGPoint(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height*0.5)
//        testview.layer.addSublayer(testCAlayer)
//
//        view.addSubview(testview)
        
        
        
        
        
        
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        sliderLabel.text = "\(Int(value))"
        
        testLabel.inflection = value
        
        
        testLabel.sliderValue = value
        testLabel.setNeedsDisplay()
        
//        curveLabel.radius = value
//        curveLabel.setNeedsDisplay()
        
        
//        testCAlayer = CALayer()
//
//        drawCurvedString(
//          on: testCAlayer,
//          text: NSAttributedString(
//            string: "This is a test string",
//            attributes: [
//                NSAttributedString.Key.foregroundColor: UIColor.purple,
//                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
//            ]),
//          angle: 270,
//          radius: value)
    }
    

}

//

//extension TextCurveViewController{
//    func drawCurvedString(on layer: CALayer, text: NSAttributedString, angle: CGFloat, radius: CGFloat) {
//      var radAngle = angle.radians
//
//      let textSize = text.boundingRect(
//        with: CGSize(width: .max, height: .max),
//        options: [.usesLineFragmentOrigin, .usesFontLeading],
//        context: nil)
//      .integral
//      .size
//
//      let perimeter: CGFloat = 2 * .pi * radius
//      let textAngle: CGFloat = textSize.width / perimeter * 2 * .pi
//
//      var textRotation: CGFloat = 0
//      var textDirection: CGFloat = 0
//
//      if angle > CGFloat(10).radians, angle < CGFloat(170).radians {
//        // bottom string
//        textRotation = 0.5 * .pi
//        textDirection = -2 * .pi
//        radAngle += textAngle / 2
//      } else {
//        // top string
//        textRotation = 1.5 * .pi
//        textDirection = 2 * .pi
//        radAngle -= textAngle / 2
//      }
//
//      for c in 0..<text.length {
//        let letter = text.attributedSubstring(from: NSRange(c..<c+1))
//        let charSize = letter.boundingRect(
//          with: CGSize(width: .max, height: .max),
//          options: [.usesLineFragmentOrigin, .usesFontLeading],
//          context: nil)
//        .integral
//        .size
//
//        let letterAngle = (charSize.width / perimeter) * textDirection
//        let x = radius * cos(radAngle + (letterAngle / 2))
//        let y = radius * sin(radAngle + (letterAngle / 2))
//
//        let singleChar = drawText(
//          on: layer,
//          text: letter,
//          frame: CGRect(
//            x: (layer.frame.size.width / 2) - (charSize.width / 2) + x,
//            y: (layer.frame.size.height / 2) - (charSize.height / 2) + y,
//            width: charSize.width,
//            height: charSize.height))
//        layer.addSublayer(singleChar)
//        singleChar.transform = CATransform3DMakeAffineTransform(CGAffineTransform(rotationAngle: radAngle - textRotation))
//        radAngle += letterAngle
//      }
//    }
//
//
//    func drawText(on layer: CALayer, text: NSAttributedString, frame: CGRect) -> CATextLayer {
//      let textLayer = CATextLayer()
//      textLayer.frame = frame
//      textLayer.string = text
//        textLayer.alignmentMode = CATextLayerAlignmentMode.center
//      textLayer.contentsScale = UIScreen.main.scale
//      return textLayer
//    }
//
//
//}

//extension CGFloat {
//  /** Degrees to Radian **/
//  var degrees: CGFloat {
//    return self * (180.0 / .pi)
//  }
//
//  /** Radians to Degrees **/
//  var radians: CGFloat {
//    return self / 180.0 * .pi
//  }
//}
