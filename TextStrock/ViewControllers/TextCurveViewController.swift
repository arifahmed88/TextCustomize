//
//  TextCurveViewController.swift
//  TextStrock
//
//  Created by PosterMaker on 12/18/22.
//

import UIKit
import SnapKit


class TextCurveViewController: UIViewController {
    
    @IBOutlet weak var fontSlider: UISlider!
    
    @IBOutlet weak var fontSliderLabel: UILabel!
    

    @IBOutlet weak var editTextButton: UIButton!
    var textInputView:TextInputView? = nil
    
    let curveLabel = {
        let label = CurveUILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = UIColor.hexStringToUIColor(hex: "#EEEEEE")
        label.textColor = .systemTeal
        label.text = "Hello darkness."
        label.font = UIFont(name: "DMSans-Medium", size: 30)
        label.isUserInteractionEnabled = true
        label.reverseAngle = false
        
        return label
    }()
    
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var fontSliderValue:Float = 0.0
    let fontSliderMinValue:Float = 0
    let fontSliderMaxValue:Float = 200
    
    var sliderValue:Float = 0.0
    let sliderMinValue:Float = -360.0
    let sliderMaxValue:Float = 360.0
    
    var circleDiameter:CGFloat = 0.0
    
    var isviewDidLayoutSubviews = false
    
    var fontName = "DMSans-Medium"
    var fontSize:CGFloat = 30.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        curveLabel.font = UIFont(name: fontName, size: fontSize)
        
        allButtonInit()
        gestureAddInCurveLabel()
        circleDiameterCalculate()
        
        sliderValueInit()
        view.addSubview(curveLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        if !isviewDidLayoutSubviews{
//            num += 1
//            if num == 2{
//                isviewDidLayoutSubviews = true
//            }
//
//            curveLabelResize()
//        }
        curveLabelResize()
    }
    
    private func allButtonInit(){
        editTextButton.layer.borderColor = UIColor.hexStringToUIColor(hex: "#06283D").cgColor
        editTextButton.layer.borderWidth = 2.0
        editTextButton.layer.cornerRadius = 4.0
    }
    
    @IBAction func fontSliderAction(_ sender: UISlider) {
        
        fontSliderValue = sender.value
        let value = CGFloat(sender.value)
        fontSize = value
        fontSliderLabel.text = "\(Int(value))"
        let font = UIFont(name: fontName, size: fontSize)
        curveLabel.font = font
        
        circleDiameterCalculate()
        curveLabelResize()
    }
    @IBAction func edittextButtonAction(_ sender: Any) {
        textInputView = TextInputView(frame: UIScreen.main.bounds)
        
        if let textInputView{
            textInputView.delegate = self
            textInputView.setText(text: "")
            
            textInputView.alpha = 0.0
            view.addSubview(textInputView)
            
            UIView.animate(withDuration: 0.5, animations: {
                textInputView.alpha = 1.0
            })
        }
    }
    
    
    func gestureAddInCurveLabel(){
        let panGesture = UIPanGestureRecognizer(target: self,action:#selector(panGestureAction(gesture:)))
        panGesture.delegate = self
        curveLabel.addGestureRecognizer(panGesture)
    }
    
    private func circleDiameterCalculate(){
        let textFontSize = curveLabel.text?.size(withAttributes: [NSAttributedString.Key.font: curveLabel.font ?? UIFont.boldSystemFont(ofSize: CGFloat(24.0))]) ?? CGSize(width: 100, height: 100)
        
        var diameter:CGFloat = ((textFontSize.width / (2 * .pi))*2)
        diameter += textFontSize.height*2
        print("circleDiameter = \(diameter)")
        circleDiameter = diameter
    }
    
    private func curveLabelResize(){
        let originX:CGFloat = 20
        let originY:CGFloat = 200
        let textFontSize = curveLabel.text?.size(withAttributes: [NSAttributedString.Key.font: curveLabel.font ?? UIFont.boldSystemFont(ofSize: CGFloat(24.0))]) ?? CGSize(width: 100, height: 100)
        
        curveLabel.frame = CGRect(origin: CGPoint(x: originX, y: originY), size: CGSize(width: textFontSize.width, height: circleDiameter))
        
        
        let deviceSize = UIScreen.main.bounds.size
        curveLabel.center = CGPoint(x: deviceSize.width*0.5, y: deviceSize.height*0.5)
        
        curveText(value: CGFloat(sliderValue))
    }
    
    private func sliderValueInit(){
        slider.minimumValue = sliderMinValue
        slider.maximumValue = sliderMaxValue
        slider.value = sliderValue
        sliderLabel.text = "\(Int(sliderValue))"
        
        fontSliderValue = Float(fontSize)
        fontSlider.minimumValue = fontSliderMinValue
        fontSlider.maximumValue = fontSliderMaxValue
        fontSlider.value = fontSliderValue
        fontSliderLabel.text = "\(Int(fontSliderValue))"
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    @IBAction func sliderAction(_ sender: UISlider) {
        sliderValue = sender.value
        let value = CGFloat(sender.value)
        sliderLabel.text = "\(Int(value))"
        curveText(value: value)
    }
    
    @objc func panGestureAction(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: curveLabel)
        switch gesture.state {
        case .began:
            print("start")
            break
        case .ended, .cancelled, .failed:
            print("End")
            break
        case .changed:
            curveLabel.center = CGPoint(x:self.curveLabel.center.x + translation.x, y: self.curveLabel.center.y + translation.y)
            
        default:
            break
        }
        gesture.setTranslation(CGPoint.zero, in: self.curveLabel)
    }
    
    fileprivate func curveText(value: CGFloat) {
        
        curveLabel.reverseAngle = value >= 0 ? false : true
        
        let sliderValue:CGFloat = abs(CGFloat(sliderMaxValue) - abs(value))
        
        let newValue:CGFloat = rangeConverter(value: Float(sliderValue), OldMin: 0, OldMax: Int(sliderMaxValue), NewMin: 0, NewMax: 100)/10
        let convertedValue = exp(newValue)
        
        curveLabel.sliderValue = convertedValue
        
        
//        if value > 0{
//
//            let newValue:CGFloat = rangeConverter(value: Float(value), OldMin: 0, OldMax: Int(sliderMaxValue), NewMin: 0, NewMax: 100)/10
//            let convertedValue = exp(newValue)
//
//            curveLabel.sliderValue = convertedValue
//
//        } else
//        {
//            curveLabel.sliderValue = value
//        }
        curveLabel.setNeedsDisplay()
    }
    
    private func rangeConverter(value:Float,OldMin:Int,OldMax:Int,NewMin:Int,NewMax:Int) -> CGFloat {
        let OldValue = Int(value)
        let NewValue = (((OldValue - OldMin) * (NewMax - NewMin)) / (OldMax - OldMin)) + NewMin
        return CGFloat(NewValue)
    }
}

extension TextCurveViewController:TextInputViewDelegate{
    func buttonAction(text: String?) {
        
        if let textInputView{
            UIView.animate(withDuration: 0.5, animations: {
                textInputView.alpha = 0.0
            },completion: {_ in
                textInputView.removeFromSuperview()
            })
        }
        //textInputView = nil
        
        if let textString = text{
            let newtext = textString.trimmingCharacters(in: .whitespaces)
            if newtext.isEmpty { return}
            
            curveLabel.text = newtext
            circleDiameterCalculate()
            curveLabelResize()
        }
        
    }
}

extension TextCurveViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

