//
//  ViewController.swift
//  TextStrock
//
//  Created by PosterMaker on 11/20/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var GradientTempView: UIView!
    
    @IBOutlet weak var strockFontColorlabel: UILabel!
    @IBOutlet weak var strockFontColorSwitch: UISwitch!
    
    @IBOutlet weak var fontBarView: FontBarView!
    
    
    @IBOutlet weak var gradientColorBarView: GradientColorVarView!
    @IBOutlet weak var colorBarView: ColorBarview!
    
    @IBOutlet weak var holderView: UIView!
    
    @IBOutlet weak var strockSlider: UISlider!
    
    @IBOutlet weak var strockSliderlabel: UILabel!
    @IBOutlet weak var fontSlider: UISlider!
    
    @IBOutlet weak var fontSliderlabel: UILabel!
    @IBOutlet weak var transparentSwitch: UISwitch!
    
    
    @IBOutlet weak var gradientSlider: UISlider!
    @IBOutlet weak var gradientSliderlabel: UILabel!
    
    var gAngle:Float = 0
    var fontSize:Float = 100
    var strockSize:Float = 0
    var textColor:UIColor? = UIColor.cyan
    var strockColor = UIColor.lightGray
//    var gradientTextColor = GradientColor(firstColor: UIColor.hexStringToUIColor(hex: "#425F57"), secondColor: UIColor.hexStringToUIColor(hex: "#E26868"))
    var gradientTextColor:GradientColor? = nil
    var fontname = "Copperplate"
    var labelText = "ARIF AHMED"
    
    var isOutline = true
    
    var customLabel = {
        var label = CustomLabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = "ARIF AHMED"
        label.font = UIFont(name: "Chalkduster", size: 50)
        label.textAlignment  = .center
        
        label.textColor = .red
        label.isUserInteractionEnabled = true
//        label.backgroundColor = .lightGray
        label.sizeToFit()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        strockSlider.minimumValue = 0
        strockSlider.maximumValue = 30
        strockSlider.value = strockSize
        
        fontSlider.minimumValue = 10
        fontSlider.maximumValue = 150
        fontSlider.value = fontSize
        
        transparentSwitch.isOn = false
        customLabelAdd()
        
        colorBarView.delegate = self
        fontBarView.delegate = self
        gradientColorBarView.delegate = self
        
        fontSliderlabel.text = "\(Int(fontSize))"
        customLabelFontChange(value: CGFloat(fontSize))
        strockSliderlabel.text = "\(Int(strockSize))"
        customLabelOutlineChange(value: CGFloat(strockSize))
        
        customLabel.text = labelText
        customLabelResize()
        
        gestureAddInLabel()
        
        gradientSlider.value = 0
        gradientSlider.maximumValue = 360
        gradientSlider.minimumValue = 0
        gradientSliderlabel.text = "\(0)"
    }
    
    func gestureAddInLabel(){
        let panGesture = UIPanGestureRecognizer(target: self,action:#selector(panGestureAction(gesture:)))
        panGesture.delegate = self
        customLabel.addGestureRecognizer(panGesture)
        
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(zoomCropFrameView(gesture:)))
//        pinchGesture.delegate = self
//        customLabel.addGestureRecognizer(pinchGesture)
        
    }
    
    @objc func panGestureAction(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: customLabel)
        switch gesture.state {
        case .began:
            print("start")
            break
        case .ended, .cancelled, .failed:
            print("End")
            break
        case .changed:
            customLabel.center = CGPoint(x:self.customLabel.center.x + translation.x, y: self.customLabel.center.y + translation.y)
            
        default:
            break
        }
        gesture.setTranslation(CGPoint.zero, in: self.customLabel)
    }
    
    
    @IBAction func gradientSliderAction(_ sender: UISlider) {
        
        gAngle = sender.value
        gradientSliderlabel.text = "\(Int(gAngle))"
        
        if let color = gradientTextColor{
            GradientTempView.backgroundColor = color.getGradientUIColor(in: GradientTempView.frame,angle: CGFloat(gAngle))
            customLabel.textGradientColorAdd(gColor: color,angel: CGFloat(gAngle))
        }
        
        
        
    }
    
    
    
//    @objc func zoomCropFrameView(gesture: UIPinchGestureRecognizer) {
//        let newPinchScale = abs(gesture.scale)
//
//        switch gesture.state {
//        case .began:
//            print("start")
//            break
//        case .ended, .cancelled, .failed:
//            print("End")
//            break
//        case .changed:
//
//            let center = customLabel.center
//            let newfontSize = CGFloat(fontSize)*newPinchScale
//            customLabelFontChange(value: newfontSize)
//
//            customLabel.center = center
//            customLabel.setNeedsDisplay()
//
//        default:
//            break
//        }
//        gesture.scale = 1.0
//    }
    
    
    func customLabelAdd(){
        customLabel.font = UIFont(name: fontname, size: CGFloat(fontSize))
        customLabel.textColor = textColor
        customLabel.strockColorChange(color: strockColor)
        customLabel.strockSizeChange(value: CGFloat(strockSize))
        
        let centerX = UIScreen.main.bounds.width*0.5
//        customLabel.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width*2, height: 200))
        customLabel.sizeToFit()
        customLabel.center = CGPoint(x: centerX, y: 200)
        
        
        view.addSubview(customLabel)
    }
    
    func customLabelResize(){
        let font = UIFont(name: fontname, size: CGFloat(fontSize)) ?? UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
       
        let itemSize = labelText.size(withAttributes: [
            NSAttributedString.Key.font : font
        ])
        let center = customLabel.center
        let offsetValue:CGFloat = (60/CGFloat(fontSize))
        customLabel.frame.size = CGSize(width: itemSize.width+(30*offsetValue), height: itemSize.height+(30*offsetValue))
        customLabel.center = center
    }
    
    
    @IBAction func strockSliderAction(_ sender: UISlider) {
        strockSize = strockSlider.value
        strockSliderlabel.text = "\(Int(strockSize))"
        
        customLabelOutlineChange(value: CGFloat(strockSize))
    }
    
    
    @IBAction func fontSliderAction(_ sender: UISlider) {
        fontSize = fontSlider.value
        fontSliderlabel.text = "\(Int(fontSize))"
        customLabelFontChange(value: CGFloat(fontSize))
    }
    
    private func customLabelFontChange(value:CGFloat){
        customLabel.font = UIFont(name: fontname, size: value)
        customLabelResize()
    }
    
    private func customLabelOutlineChange(value:CGFloat){
        customLabel.strockSizeChange(value: value)
    }
    
    @IBAction func strockFontColorSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            isOutline = true
        } else {
            isOutline = false
        }
        strockFontColorLabelTextChange()
        colorBarView.collectionView.reloadData()
    
        
    }
    @IBAction func transparentSwitchAction(_ sender: UISwitch) {
        
        if sender.isOn {
            customLabel.textColorChange(color: UIColor.clear)
        } else {
            guard let gColor = gradientTextColor else {
                if let color = textColor{
                    customLabel.textColorChange(color: color)
                }
                return
            }
            customLabel.textGradientColorAdd(gColor: gColor)
            
        }
        
    }
    
    func strockFontColorLabelTextChange(){
        if isOutline {
            strockFontColorlabel.text = "Outline"
        } else {
            strockFontColorlabel.text = "Font"
        }
    }
}

extension ViewController:ColorBarviewDelegate{
    func selectedColor(color: UIColor) {
        
        if isOutline{
            strockColor = color
            customLabel.strockColorChange(color: strockColor)
        } else {
            textColor = color
            gradientTextColor = nil
            customLabel.textColorChange(color: color)
            transparentSwitch.isOn = false
        }
    }
}

extension ViewController:FontBarViewDelegate{
    func fontChange(fontName: String?) {
        guard let name = fontName else {return}
        fontname = name
        customLabel.font = UIFont(name: name, size: CGFloat(fontSize))
        customLabel.setNeedsDisplay()
        customLabelResize()
    }
    
   
}


extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}


extension ViewController:GradientColorVarViewDelegate{
    func selectedGradientColor(gColor:GradientColor) {
        gradientTextColor = gColor
        textColor = nil
        customLabel.textGradientColorAdd(gColor: gColor)
        
        GradientTempView.backgroundColor = gColor.getGradientUIColor(in: GradientTempView.frame)
    }
}
