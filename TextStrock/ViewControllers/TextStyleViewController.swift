//
//  TextStyleViewController.swift
//  TextStrock
//
//  Created by PosterMaker on 12/14/22.
//

import UIKit

protocol TextStyleViewControllerDelegate{
    func textStyleApply(style: TextStyle?)
}

class TextStyleViewController: UIViewController {
    
    @IBOutlet weak var applyStyleButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var textEditButton: UIButton!
    
    @IBOutlet weak var textStyleBarView: TextStyleBarView!
    @IBOutlet weak var mainLabel: CustomLabel!
    
    var textInputView:TextInputView? = nil
    
    var labelText = "goal"
    var fontSize:CGFloat = 150
    var fontName = "Oswald-Bold"
    var delegate:TextStyleViewControllerDelegate?
    var selecteTextStyle:TextStyle? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        labelInit()
        allButtonInit()
        textStyleBarView.delegate = self
        gestureAddInLabel()
    }
    
    
    private func labelInit(){
        mainLabel.text = labelText
        mainLabel.font = UIFont(name: fontName, size: fontSize)
        mainLabel.textAlignment = .center
        mainLabel.sizeToFit()
        mainLabel.isUserInteractionEnabled = true
        
        let size = UIScreen.main.bounds.size
        mainLabel.center = CGPoint(x: size.width*0.5, y: size.height*0.5)
        
        
    }
    
    private func allButtonInit(){
        textEditButton.layer.borderColor = UIColor.hexStringToUIColor(hex: "#06283D").cgColor
        textEditButton.layer.borderWidth = 2.0
        textEditButton.layer.cornerRadius = 4.0
        
        
//        closeButton.layer.borderColor = UIColor.hexStringToUIColor(hex: "#06283D").cgColor
//        closeButton.layer.borderWidth = 2.0
//        closeButton.layer.cornerRadius = closeButton.bounds.height*0.5
        
        applyStyleButton.layer.borderColor = UIColor.hexStringToUIColor(hex: "#06283D").cgColor
        applyStyleButton.layer.borderWidth = 2.0
        applyStyleButton.layer.cornerRadius = 4.0
        
    }
    
    func gestureAddInLabel(){
        let panGesture = UIPanGestureRecognizer(target: self,action:#selector(panGestureAction(gesture:)))
        panGesture.delegate = self
        mainLabel.addGestureRecognizer(panGesture)
        
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(zoomCropFrameView(gesture:)))
//        pinchGesture.delegate = self
//        mainLabel.addGestureRecognizer(pinchGesture)
        
    }
    
    @IBAction func applyStyleButtonAction(_ sender: Any) {
        delegate?.textStyleApply(style: selecteTextStyle)
        dismiss(animated: true)
    }
    @IBAction func textEditButtonAction(_ sender: Any) {
        textInputView = TextInputView(frame: UIScreen.main.bounds)
        
        if let textInputView{
            textInputView.delegate = self
            textInputView.setText(text: "")
            view.addSubview(textInputView)
        }
    }
    @objc func panGestureAction(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: mainLabel)
        switch gesture.state {
        case .began:
            print("start")
            break
        case .ended, .cancelled, .failed:
            print("End")
            break
        case .changed:
            mainLabel.center = CGPoint(x:self.mainLabel.center.x + translation.x, y: self.mainLabel.center.y + translation.y)
            
        default:
            break
        }
        gesture.setTranslation(CGPoint.zero, in: self.mainLabel)
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    func applyStyle(style:TextStyle){
        
        if let fontName = style.fontName {
            mainLabel.font = UIFont(name: fontName, size: fontSize)
        }
        
        if let fontcolor = style.textColor {
            mainLabel.textColorChange(color: fontcolor)
        }
        
        if let fontGradientColor = style.gradientColor {
            mainLabel.textGradientColorAdd(gColor: fontGradientColor.gradientColor,angel: fontGradientColor.angle)
        }else {
            mainLabel.textGradientColor = nil
        }
        
        if let texture = style.texture {
            mainLabel.textTextureChange(textTexture: texture)
        } else {
            mainLabel.texture = nil
        }
        
        if let shadow = style.shadow {
            
//            mainLabel.layer.borderWidth = 2.0
//            mainLabel.layer.borderColor = UIColor.systemBlue.cgColor
            
            
//            let tShadow = NSShadow()
//            tShadow.shadowColor = shadow.color
//            tShadow.shadowBlurRadius = shadow.blur
//            tShadow.shadowOffset = CGSize(width: 50, height: 100)
//
//            let strokeTextAttributes: [NSAttributedString.Key : Any] = [
//                NSAttributedString.Key.strokeColor : UIColor.red,
//                NSAttributedString.Key.foregroundColor : UIColor.gray,
//                NSAttributedString.Key.strokeWidth : -2.0,
//                NSAttributedString.Key.shadow : tShadow
//            ]
//            let attributedString = NSAttributedString(string: mainLabel.text ?? "arif", attributes: strokeTextAttributes)
//            mainLabel.attributedText = attributedString

            
            mainLabel.layer.shadowColor = shadow.color.cgColor
            mainLabel.layer.shadowOffset = shadow.offset
            mainLabel.layer.shadowRadius = shadow.blur
            mainLabel.layer.shadowOpacity = Float(shadow.opacity)
        } else {
            mainLabel.layer.shadowColor = UIColor.clear.cgColor
            mainLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
            mainLabel.layer.shadowRadius = 0.0
            mainLabel.layer.shadowOpacity = 0.0
        }
        
        if let outLine = style.outLine {
            mainLabel.strockSizeChange(value: outLine.lineWidth)
            if let oColor = outLine.color{
                mainLabel.strockColorChange(color: oColor)
            }
            if let ogColor = outLine.gragientColor{
                mainLabel.strockGradientColorAdd(gColor: ogColor)
            }
            
        } else{
            mainLabel.strockSizeChange(value: 0.0)
            mainLabel.strockColorChange(color: .white)
        }
        
        customLabelResize()
    }
    
    func customLabelResize(){
        let font = mainLabel.font ?? UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
       
        let itemSize = labelText.size(withAttributes: [
            NSAttributedString.Key.font : font
        ])
       
        let offsetValue:CGFloat = (CGFloat(fontSize)*40)/60
        mainLabel.frame.size = CGSize(width: itemSize.width+offsetValue+30, height: itemSize.height+offsetValue+30)
        
        let size = UIScreen.main.bounds.size
        mainLabel.center = CGPoint(x: size.width*0.5, y: size.height*0.5)
        mainLabel.setNeedsDisplay()
        
    }
    
}

extension TextStyleViewController:TextStyleBarViewDelegate{
    func styleApply(style: TextStyle) {
        selecteTextStyle = style
        applyStyle(style: style)
    }
}

extension TextStyleViewController:TextInputViewDelegate{
    func buttonAction(text: String?) {
        
        if let textInputView{
            textInputView.removeFromSuperview()
        }
        textInputView = nil
        
        if let textString = text{
            let newtext = textString.trimmingCharacters(in: .whitespaces)
            if newtext.isEmpty { return}
            mainLabel.text = newtext
            labelText = newtext
            customLabelResize()
            
            let size = UIScreen.main.bounds.size
            mainLabel.center = CGPoint(x: size.width*0.5, y: size.height*0.5)
        }
        
    }
}

extension TextStyleViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
