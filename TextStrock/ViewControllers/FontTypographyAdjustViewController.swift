//
//  FontTypographyAdjustViewController.swift
//  TextStrock
//
//  Created by PosterMaker on 12/5/22.
//

import UIKit

class FontTypographyAdjustViewController: UIViewController {
    
    
    @IBOutlet weak var fontSlider: UISlider!
    @IBOutlet weak var fontbarview: FontBarView!
    
    @IBOutlet weak var label: CustomLabelNew!
    
    @IBOutlet weak var fonntSliderLabel: UILabel!
    
    var textInputView:TextInputView? = nil
    
    let shapeLayer = CAShapeLayer()
    
    var fontSize:CGFloat = 50
    var fontname = "Acme-Regular"
    var labelText = "good Bad & Ugly"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.fillColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 1.0
        // add the new layer to our custom view
        label.layer.addSublayer(shapeLayer)
        
        fontbarview.delegate = self

        labelInitialize()
        gestureAddInLabel()
        fontSliderInitialize()
        
       
    }
    
    func fontSliderInitialize(){
        fontSlider.maximumValue = 300
        fontSlider.minimumValue = 10
        fontSlider.value = Float(fontSize)
        fonntSliderLabel.text = "\(Int(fontSlider.value))"
    }
    
    func labelInitialize(){
        label.clipsToBounds = false
        label.layer.masksToBounds = false
       
        label.backgroundColor = .orange
        label.text = labelText
        label.font = UIFont(name: fontname, size: fontSize)
        label.textAlignment  = .center
        label.numberOfLines = 0
    
        
        label.textColor = .gray
        label.isUserInteractionEnabled = true
        customLabelResize()
        
        
        label.center = CGPoint(x: UIScreen.main.bounds.width*0.5, y: 220)
    }
    
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func gestureAddInLabel(){
        let panGesture = UIPanGestureRecognizer(target: self,action:#selector(panGestureAction(gesture:)))
        panGesture.delegate = self
        label.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(zoomCropFrameView(gesture:)))
        pinchGesture.delegate = self
        label.addGestureRecognizer(pinchGesture)
        
    }
    
    @objc func panGestureAction(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: label)
        switch gesture.state {
        case .began:
            print("start")
            break
        case .ended, .cancelled, .failed:
            print("End")
            break
        case .changed:
            label.center = CGPoint(x:self.label.center.x + translation.x, y: self.label.center.y + translation.y)
            
        default:
            break
        }
        gesture.setTranslation(CGPoint.zero, in: self.label)
    }
    
    
    @objc func zoomCropFrameView(gesture: UIPinchGestureRecognizer) {
        let newPinchScale = abs(gesture.scale)

        switch gesture.state {
        case .began:
            print("start")
            break
        case .ended, .cancelled, .failed:
            print("End")
            break
        case .changed:
            let center = label.center
            //let newfontSize = CGFloat(fontSize)*newPinchScale
            
            let newSize = CGSize(width: label.bounds.size.width*newPinchScale, height: label.bounds.size.height*newPinchScale)
            label.frame.size = newSize
            label.center = center
            
            
//            let fontIntSize = Int(newfontSize)
            
//            if  fontIntSize <= 300 && fontIntSize >= 10 {
//                fontSlider.value = Float(fontIntSize)
//                fonntSliderLabel.text = "\(Int(newfontSize))"
//                fontSize = CGFloat(fontIntSize)
//
//                customLabelFontChange(value: newfontSize)
//                label.center = center
//                label.setNeedsDisplay()
//            }
            
        default:
            break
        }
        gesture.scale = 1.0
    }
    
    private func customLabelFontChange(value:CGFloat){
        label.font = UIFont(name: fontname, size: value)
        customLabelResize()
    }
    
    var num = 1
    
    
    func customLabelResize(){
        
//        let offset = -((5*fontSize)/50)
//        let sttrStr = NSAttributedString.init(string: label.text ?? "",
//                                              attributes:[NSAttributedString.Key.baselineOffset: offset])
//        label.attributedText = sttrStr
        
        
        let font = UIFont(name: fontname, size: CGFloat(fontSize)) ?? UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
       
        let itemSize = labelText.size(withAttributes: [
            NSAttributedString.Key.font : font
        ])
        
        let center = label.center
        let offsetValue:CGFloat = (0/CGFloat(fontSize))
        label.frame.size = CGSize(width: itemSize.width+(30*offsetValue), height: itemSize.height+(30*offsetValue))
        label.center = center
        
        //
        let tempHeight = itemSize.height - (font.ascender - font.descender)
        
        print("tempHeight = \(tempHeight)")
        
//        print("num\(num) = \(label.font.ascender - label.font.capHeight)")
//        num+=1
//        //let baselineY = customLabel.frame.origin.y + customLabel.font.ascender
//
//        let numberOfLine = labelText.components(separatedBy:"\n").count
        
        
//        let topSpace = abs(label.font.ascender - label.font.capHeight)
//
//        let tempH:CGFloat = (max(label.font.ascender,label.font.capHeight) - label.font.descender + topSpace) * CGFloat(numberOfLine)
//
//        //let lineHeight:CGFloat = label.font.lineHeight * CGFloat((numberOfLine-1))
//
////        let singleLineHeight = "arif".size(withAttributes: [
////            NSAttributedString.Key.font : font
////        ]).height
//
//
//        print("numberOfLine = \(numberOfLine)")
//
//        label.frame.size = CGSize(width: itemSize.width , height: tempH)
//        label.center = center
        
        
        
        
//        let tH = labelHeight(for: font, numberOfLines: numberOfLine)
//        label.frame.size = CGSize(width: itemSize.width , height: tH)
//        label.center = center
        
        
        //
        
        
        
//        label.sizeThatFits(CGSize(width: itemSize.width, height: itemSize.height))
        
//        if let labelfont = label.font{
//            let attributedText: NSAttributedString = NSAttributedString(string: label.text ?? "",attributes: [.font:  labelfont])
//
//            let labelFrame = attributedText.boundingRect(with: CGSize(width: label.frame.size.width, height: CGFLOAT_MAX),options: .usesLineFragmentOrigin, context: nil)
//
//            let labelheight = ceil(labelFrame.size.height)
//
//            label.frame.size = CGSize(width: itemSize.width , height: labelheight)
//            label.center = center
//        }
        
        
        
        
        
//        //newApproach
//        let h = font.ascender*2
//        label.frame.size = CGSize(width: itemSize.width, height: h)
//        label.center = center
//        label.setNeedsDisplay()
        
        
        
        
        //base line draw
        let baselineY = label.font.ascender
        
        //print("baselineY = \(baselineY)")
        shapeLayer.frame = label.bounds
        let rectpath = UIBezierPath(rect: CGRect(origin: CGPoint(x: 0, y: baselineY), size: CGSize(width: label.frame.size.width, height: 1)))
        shapeLayer.path = rectpath.cgPath
       // label.baseLineDraw(yPosition: baselineY)
        
    }
    
    
    func labelHeight(for font: UIFont, numberOfLines: Int, lineSpacing: CGFloat? = nil) -> CGFloat {
        let text = Array(repeating: "Some text", count: numberOfLines).joined(separator: "\n")
        label.numberOfLines = 0
        var attributes: [NSAttributedString.Key: Any] = [.font: font]
        if let lineSpacing = lineSpacing {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            attributes[.paragraphStyle] = paragraphStyle
        }
        label.attributedText = NSMutableAttributedString(string: text, attributes: attributes)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }
    

    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func addtextAction(_ sender: Any) {
        textInputView = TextInputView(frame: UIScreen.main.bounds)
        if let textInputView{
            textInputView.delegate = self
            textInputView.setText(text: "")
            view.addSubview(textInputView)
        }
    }
    
    
    @IBAction func fontSliderAction(_ sender: Any) {
        fontSize = CGFloat(fontSlider.value)
        fonntSliderLabel.text = "\(Int(fontSize))"
        customLabelFontChange(value: CGFloat(fontSize))
    }
    
}

extension FontTypographyAdjustViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

extension FontTypographyAdjustViewController:FontBarViewDelegate{
    func fontChange(fontName: String?) {
        guard let name = fontName else {return}
        fontname = name
        label.font = UIFont(name: name, size: CGFloat(fontSize))
        label.setNeedsDisplay()
        customLabelResize()
    }
}


extension FontTypographyAdjustViewController:TextInputViewDelegate{
    func buttonAction(text: String?) {
        
        if let textInputView{
            textInputView.removeFromSuperview()
        }
        textInputView = nil
        if let textString = text{
            let newtext = textString.trimmingCharacters(in: .whitespaces)
            if newtext.isEmpty { return}
            label.text = newtext
            labelText = newtext
            customLabelResize()
            
        }
        
    }
}
