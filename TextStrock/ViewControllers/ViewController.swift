//
//  ViewController.swift
//  TextStrock
//
//  Created by PosterMaker on 11/20/22.
//

import UIKit

enum viewType:String{
    case text = "Text"
    case image = "Image"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var BGImageView: UIImageView!
    @IBOutlet weak var blendBarView: BlendBarView!
    @IBOutlet weak var textureBarView: TextureBarView!
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
    
    @IBOutlet weak var textImageSelectSwitch: UISwitch!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    
    var textInputView:TextInputView? = nil
    
    var gAngle:Float = 0
    var fontSize:Float = 60
    var strockSize:Float = 0
    var textColor:UIColor? = UIColor.systemBlue
    var strockColor:UIColor? = UIColor.lightGray
    var gradientTextColor:GradientColor? = nil
    var textTexture:Texture? = nil
    var gradientTextStrockColor:GradientColor? = nil
    
    var fontname = "CabinSketch-Bold"
    var labelText = "ARIF AHMED"
    
    var isOutline = true
    
    var selectedView:viewType = .text
    
    var customLabel = {
        var label = CustomLabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = "ARIF AHMED"
        label.font = UIFont(name: "CabinSketch-Bold", size: 50)
        label.textAlignment  = .center
        label.numberOfLines = 0
        
        label.textColor = .red
        label.isUserInteractionEnabled = true
        label.sizeToFit()
        
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.borderWidth = 2.0
        
        return label
    }()
    
    var customImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.isUserInteractionEnabled = true
        transparentSwitch.isOn = false
        
        customImageViewAdd()
        customLabelAdd()
        sliderInitialize()
        
        colorBarView.delegate = self
        fontBarView.delegate = self
        textureBarView.delegate = self
        blendBarView.delegate = self
        
        customLabelFontChange(value: CGFloat(fontSize))
        customLabelOutlineChange(value: CGFloat(strockSize))
        
        customLabel.text = labelText
        customLabelResize()
        gestureAddInLabel()
        
        gestureAddInImageView()
        
        blendindViewTypeInit()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        strockFontColorSwitch.isOn = false
        isOutline = false
        let gColor = colorBarView.gradientColorList.uiGradentColorList[0]
        selectedGradientColor(gColor: gColor)
        gradientTextColor = gColor
        textColor = nil
        
//        fontChange(fontName: fontBarView.fontList[1].fontName)
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
    
    func blendindViewTypeInit(){
        textLabel.textColor = UIColor.hexStringToUIColor(hex: "#FB2576")
        imageLabel.textColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1)
        textImageSelectSwitch.isOn = false
    }
    
    func gestureAddInImageView(){
        let panGesture = UIPanGestureRecognizer(target: self,action:#selector(panGestureAction(gesture:)))
        panGesture.delegate = self
        customImageView.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(zoomImageView(gesture:)))
        pinchGesture.delegate = self
        customImageView.addGestureRecognizer(pinchGesture)
        
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
        guard let gestureView = gesture.view else {return}
        let translation = gesture.translation(in: gestureView)
        switch gesture.state {
        case .began:
            //print("start")
            break
        case .ended, .cancelled, .failed:
            //print("End")
            break
        case .changed:
            gestureView.center = CGPoint(x:gestureView.center.x + translation.x, y: gestureView.center.y + translation.y)
            
        default:
            break
        }
        gesture.setTranslation(CGPoint.zero, in: gestureView)
    }
    
    
    @IBAction func textImageSelectSwitchAction(_ sender: UISwitch) {
        if sender.isOn{
            textLabel.textColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1)
            imageLabel.textColor = UIColor.hexStringToUIColor(hex: "#FB2576")
            selectedView = .image
        } else {
            textLabel.textColor = UIColor.hexStringToUIColor(hex: "#FB2576")
            imageLabel.textColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1)
            selectedView = .text
        }
        
        blendBarView.collectionViewReset()
        
    }
    
    @IBAction func imageButtonAction(_ sender: Any) {
        let vc = ImageSelectViewController()
        vc.isFromBG = false
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @IBAction func bgChangeButtonAction(_ sender: Any) {
        
        let vc = ImageSelectViewController()
        vc.isFromBG = true
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let vc = TextStyleViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
    @IBAction func curveButtonAction(_ sender: Any) {
        
        
        let vc = TextCurveViewController()
//        let vc = MosaicViewController()
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
    
    @objc func zoomImageView(gesture: UIPinchGestureRecognizer) {
        let newPinchScale = abs(gesture.scale)

        switch gesture.state {
        case .changed:
            let center = customImageView.center
            let width = customImageView.bounds.width * newPinchScale
            let height = customImageView.bounds.height * newPinchScale
            
            customImageView.frame.size = CGSize(width: width, height: height)
            customImageView.center = center
            
        default:
            break
        }
        gesture.scale = 1.0
    }
    
    
    
    @objc func zoomCropFrameView(gesture: UIPinchGestureRecognizer) {
        let newPinchScale = abs(gesture.scale)

        switch gesture.state {
        case .began:
//            print("start")
            break
        case .ended, .cancelled, .failed:
//            print("End")
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
    
    func customImageViewAdd(){
        customImageView.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))
        let centerX = UIScreen.main.bounds.width*0.5
        customImageView.center = CGPoint(x: centerX, y: 200)
        canvasView.addSubview(customImageView)
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
        canvasView.addSubview(customLabel)
    }
    
//    var num = 1
    func customLabelResize(){
        let font = UIFont(name: fontname, size: CGFloat(fontSize)) ?? UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
       
        let itemSize = labelText.size(withAttributes: [
            NSAttributedString.Key.font : font
        ])
        let center = customLabel.center
        let offsetValue:CGFloat = (CGFloat(fontSize)*40)/60
        customLabel.frame.size = CGSize(width: itemSize.width+offsetValue, height: itemSize.height+offsetValue)
        customLabel.center = center
        
        //print("num\(num) = \(customLabel.font.ascender - customLabel.font.capHeight)")
//        num+=1
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

extension ViewController:TextureBarViewDelegate{
    func selectedTexture(texture: Texture) {
//        transparentSwitch.isOn = false
//        gAngle = 0.0
//        gradientSlider.value = 0.0
//
//        gradientTextColor = nil
//        textColor = nil
//
//        textTexture = texture
        
        
        let newColor = texture.getTextureUIColor(in: customLabel.bounds)
        
//        customLabel.textStrockTextureChange(textTextureColor: newColor)
        customLabel.textTextureChange(textTexture: texture)
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

//extension ViewController:FontFamilyDelegate{
//    func selected(fontFamily: String) {
//        let name = fontFamily
//        fontname = name
//        customLabel.font = UIFont(name: name, size: CGFloat(fontSize))
//        customLabel.setNeedsDisplay()
//        customLabelResize()
//    }
//
//}

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

extension ViewController:BlendBarViewDelegate{
    func blendModeChange(blendModeName: String?) {
        
        if selectedView == .text{
            if let blendModeName{
                if blendModeName == "None"{
                    customLabel.layer.compositingFilter = nil
                } else {
                    customLabel.layer.compositingFilter = blendModeName
                }
            }
        } else if selectedView == .image{
            if let blendModeName{
                if blendModeName == "None"{
                    customImageView.layer.compositingFilter = nil
                } else {
                    customImageView.layer.compositingFilter = blendModeName
                }
            }
        }
        
        
        
        
    }
}

extension ViewController:ImageSelectViewControllerDelegate{
    func selectedImage(image: UIImage?, isForBG: Bool) {
        if isForBG{
            BGImageView.image = image
        } else{
            customImageView.image = image
        }
    }
}


extension ViewController:TextStyleViewControllerDelegate{
    func textStyleApply(style: TextStyle?) {
        if let style{
            applyStyle(style: style)
        }
    }
    
    
    func applyStyle(style:TextStyle){
        
        if let fontName = style.fontName {
            customLabel.font = UIFont(name: fontName, size: CGFloat(fontSize))
        }
        
        if let fontcolor = style.textColor {
            customLabel.textColorChange(color: fontcolor)
        }
        
        if let fontGradientColor = style.gradientColor {
            customLabel.textGradientColorAdd(gColor: fontGradientColor.gradientColor,angel: fontGradientColor.angle)
        }else {
            customLabel.textGradientColor = nil
        }
        
        if let texture = style.texture {
            customLabel.textTextureChange(textTexture: texture)
        } else {
            customLabel.texture = nil
        }
        
        if let shadow = style.shadow {
            customLabel.layer.shadowColor = shadow.color.cgColor
            customLabel.layer.shadowOffset = shadow.offset
            customLabel.layer.shadowRadius = shadow.blur
            customLabel.layer.shadowOpacity = Float(shadow.opacity)
        } else {
            customLabel.layer.shadowColor = UIColor.clear.cgColor
            customLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
            customLabel.layer.shadowRadius = 0.0
            customLabel.layer.shadowOpacity = 0.0
        }
        
        if let outLine = style.outLine {
            customLabel.strockSizeChange(value: outLine.lineWidth)
            if let oColor = outLine.color{
                customLabel.strockColorChange(color: oColor)
            }
            if let ogColor = outLine.gragientColor{
                customLabel.strockGradientColorAdd(gColor: ogColor)
            }
            
        } else{
            customLabel.strockSizeChange(value: 0.0)
            customLabel.strockColorChange(color: .white)
        }
        
        customLabelResize()
    }
}
