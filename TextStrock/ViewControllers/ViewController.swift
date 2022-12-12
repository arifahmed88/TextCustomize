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
    
    @IBOutlet weak var colorBarView: ColorBarview!
    
    @IBOutlet weak var holderView: UIView!
    
    @IBOutlet weak var strockSlider: UISlider!
    
    @IBOutlet weak var strockSliderlabel: UILabel!
    @IBOutlet weak var fontSlider: UISlider!
    
    @IBOutlet weak var fontSliderlabel: UILabel!
    @IBOutlet weak var transparentSwitch: UISwitch!
    
    
    @IBOutlet weak var gradientSlider: UISlider!
    @IBOutlet weak var gradientSliderlabel: UILabel!
    
    var textInputView:TextInputView? = nil
    
    var gAngle:Float = 0
    var fontSize:Float = 60
    var strockSize:Float = 0
    var textColor:UIColor? = UIColor.systemBlue
    var strockColor:UIColor? = UIColor.lightGray
    var gradientTextColor:GradientColor? = nil
    var gradientTextStrockColor:GradientColor? = nil
    
    var fontname = "Copperplate"
    var labelText = "ARIF AHMED"
    
    var isOutline = true
    
    var customLabel = {
        var label = CustomLabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = "ARIF AHMED"
        label.font = UIFont(name: "Chalkduster", size: 50)
        label.textAlignment  = .center
        label.numberOfLines = 0
        
        label.textColor = .red
        label.isUserInteractionEnabled = true
        label.sizeToFit()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentSwitch.isOn = false
        customLabelAdd()
        sliderInitialize()
        
        colorBarView.delegate = self
        fontBarView.delegate = self
        
        customLabelFontChange(value: CGFloat(fontSize))
        customLabelOutlineChange(value: CGFloat(strockSize))
        
        customLabel.text = labelText
        customLabelResize()
        gestureAddInLabel()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        strockFontColorSwitch.isOn = false
        isOutline = false
        let gColor = colorBarView.gradientColorList.uiGradentColorList[0]
        selectedGradientColor(gColor: gColor)
        gradientTextColor = gColor
        textColor = nil
        
        fontChange(fontName: fontBarView.fontList[0].fontName)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    private func sliderInitialize(){
        strockSlider.minimumValue = 0
        strockSlider.maximumValue = 30
        strockSlider.value = strockSize
        strockSliderlabel.text = "\(Int(strockSize))"
        
        fontSlider.minimumValue = 10
        fontSlider.maximumValue = 300
        fontSlider.value = fontSize
        fontSliderlabel.text = "\(Int(fontSize))"
        
        gradientSlider.value = 0
        gradientSlider.maximumValue = 360
        gradientSlider.minimumValue = 0
        gradientSliderlabel.text = "\(0)"
    }
    
    func gestureAddInLabel(){
        let panGesture = UIPanGestureRecognizer(target: self,action:#selector(panGestureAction(gesture:)))
        panGesture.delegate = self
        customLabel.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(zoomCropFrameView(gesture:)))
        pinchGesture.delegate = self
        customLabel.addGestureRecognizer(pinchGesture)
        
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
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        let vc = FontTypographyAdjustViewController()
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
    }
    
    
    
    @IBAction func gradientSliderAction(_ sender: UISlider) {
        
        gAngle = sender.value
        gradientSliderlabel.text = "\(Int(gAngle))"
        
        if let color = gradientTextColor{
            GradientTempView.backgroundColor = color.getGradientUIColor(in: GradientTempView.frame,angle: CGFloat(gAngle))
            customLabel.textGradientColorAdd(gColor: color,angel: CGFloat(gAngle))
        }
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
            let center = customLabel.center
            let newfontSize = CGFloat(fontSize)*newPinchScale
            let fontIntSize = Int(newfontSize)
            if  fontIntSize <= 300 && fontIntSize >= 10 {
                fontSlider.value = Float(fontIntSize)
                fontSliderlabel.text = "\(Int(newfontSize))"
                fontSize = Float(fontIntSize)
                
                customLabelFontChange(value: newfontSize)
                customLabel.center = center
                customLabel.setNeedsDisplay()
            }
            
        default:
            break
        }
        gesture.scale = 1.0
    }
    
    
    func customLabelAdd(){
        customLabel.font = UIFont(name: fontname, size: CGFloat(fontSize))
        customLabel.textColor = textColor
        customLabel.strockColorChange(color: strockColor ?? UIColor.orange)
        customLabel.strockSizeChange(value: CGFloat(strockSize))
        
        let centerX = UIScreen.main.bounds.width*0.5
//        customLabel.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width*2, height: 200))
        customLabel.sizeToFit()
        customLabel.center = CGPoint(x: centerX, y: 200)
        view.addSubview(customLabel)
    }
    
    var num = 1
    func customLabelResize(){
        let font = UIFont(name: fontname, size: CGFloat(fontSize)) ?? UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
       
        let itemSize = labelText.size(withAttributes: [
            NSAttributedString.Key.font : font
        ])
        let center = customLabel.center
        let offsetValue:CGFloat = (60/CGFloat(fontSize))
        customLabel.frame.size = CGSize(width: itemSize.width+(30*offsetValue), height: itemSize.height+(30*offsetValue))
        customLabel.center = center
        
        print("num\(num) = \(customLabel.font.ascender - customLabel.font.capHeight)")
        num+=1
        //let baselineY = customLabel.frame.origin.y + customLabel.font.ascender
        
        
    }
    
    @IBAction func textEditButtonAction(_ sender: Any) {
        textInputView = TextInputView(frame: UIScreen.main.bounds)
        
        if let textInputView{
            textInputView.delegate = self
            textInputView.setText(text: "")
            view.addSubview(textInputView)
        }
        
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
            customLabel.strockColorChange(color: strockColor ?? UIColor.blue)
        } else {
            textColor = color
            gradientTextColor = nil
            customLabel.textColorChange(color: color)
            transparentSwitch.isOn = false
        }
    }
    
    func selectedGradientColor(gColor:GradientColor) {
        
        if isOutline{
            gradientTextStrockColor = gColor
            strockColor = nil
            customLabel.strockGradientColorAdd(gColor: gColor)
        } else {
            
            gAngle = 0.0
            gradientSlider.value = 0.0
            
            gradientTextColor = gColor
            textColor = nil
            customLabel.textGradientColorAdd(gColor: gColor)
            
            GradientTempView.backgroundColor = gColor.getGradientUIColor(in: GradientTempView.frame)
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

extension ViewController:TextInputViewDelegate{
    func buttonAction(text: String?) {
        
        if let textInputView{
            textInputView.removeFromSuperview()
        }
        textInputView = nil
        
        if let textString = text{
            let newtext = textString.trimmingCharacters(in: .whitespaces)
            if newtext.isEmpty { return}
            
            customLabel.text = newtext
            if let gradientTextColor{
                customLabel.textGradientColorAdd(gColor: gradientTextColor,angel: CGFloat(gAngle))
            }
            let centerX = UIScreen.main.bounds.width*0.5
            customLabel.sizeToFit()
            customLabel.center = CGPoint(x: centerX, y: 200)
        }
        
    }
}


extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
