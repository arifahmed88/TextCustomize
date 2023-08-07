//
//  TextCurveViewController.swift
//  TextStrock
//
//  Created by PosterMaker on 12/18/22.
//

import UIKit
import SnapKit


class TextCurveViewController: UIViewController {
   
   @IBOutlet weak var bottomScrollView: UIScrollView!
   
   @IBOutlet weak var fontOutlineSwitch: UISwitch!
   
   @IBOutlet weak var fontOutlineSwitchlabel: UILabel!
   
   @IBOutlet weak var colorBarView: ColorBarview!
   
   @IBOutlet weak var fontStrokeView: UIView!
   
   @IBOutlet weak var fontStrokeSlider: UISlider!
   
   @IBOutlet weak var fontStrokeSliderLabel: UILabel!
   
   
   
   @IBOutlet weak var fontSpaceView: UIView!
   
   @IBOutlet weak var fontSpaceSlider: UISlider!
   
   @IBOutlet weak var fontSpaceSliderLabel: UILabel!
   
   
   
   @IBOutlet weak var fontView: FontBarView!
   
   @IBOutlet weak var canvasView: UIView!
   
   @IBOutlet weak var fontSlider: UISlider!
   
   @IBOutlet weak var fontSliderLabel: UILabel!
   
   
   @IBOutlet weak var editTextButton: UIButton!
   var textInputView:TextInputView? = nil
   
   var labelPreviousCenter = {
      let deviceSize = UIScreen.main.bounds.size
      let center = CGPoint(x: deviceSize.width*0.5, y: deviceSize.height*0.5-100)
      return center
   }()
   
   let curveLabel = {
      let label = CurveUILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
      //label.translatesAutoresizingMaskIntoConstraints = false
      label.textAlignment = .center
      label.backgroundColor = UIColor.hexStringToUIColor(hex: "#EEEEEE")
      //        label.backgroundColor = .clear
      label.textColor = .black
      //        label.text = "The last of us is no more"
      label.text = "the last one"
      label.font = UIFont(name: "DMSans-Medium", size: 30)
      label.isUserInteractionEnabled = true
      label.reverseAngle = false
      label.layoutIfNeeded()
      
      return label
   }()
   
   @IBOutlet weak var sliderLabel: UILabel!
   @IBOutlet weak var slider: UISlider!
   
   var fontStrokeSliderValue:Float = 0
   let fontStrokeSliderMinValue:Float = 0.0
   let fontStrokeSliderMaxValue:Float = 1.0
   
   var fontSpaceSliderValue:Float = 0
   let fontSpaceSliderMinValue:Float = -0.8
   let fontSpaceSliderMaxValue:Float = 0.8
   
   var fontSliderValue:Float = 0.0
   let fontSliderMinValue:Float = 3.0
   let fontSliderMaxValue:Float = 400
   
   var sliderValue:Float = 0.0
   let sliderMinValue:Float = -360.0
   let sliderMaxValue:Float = 360.0
   
   var circleDiameter:CGFloat = 0.0
   
   var isviewDidLayoutSubviews = false
   
   var fontName = "DMSans-Medium"
   var fontSize:CGFloat = 30.0
   var fontSpace:CGFloat = 0.0
   
   var curveLabelHeightOffset:CGFloat = 30
   
   override func viewDidLoad() {
      super.viewDidLoad()
      colorBarView.delegate = self
      
      curveLabel.font = UIFont(name: fontName, size: fontSize)
      curveLabel.clipsToBounds = false
      curveLabel.layer.masksToBounds = false
      
      allButtonInit()
      gestureAddInCurveLabel()
      circleDiameterCalculate()
      
      sliderValueInit()
      switchInit()
      
      canvasView.addSubview(curveLabel)
      
      fontView.delegate = self
      
      if let font = curveLabel.font,let text = curveLabel.text{
         let atText = getAttributedText(font: font, text: text)
         curveLabel.attributedText = atText
      }
      
      curveText(value: CGFloat(sliderValue))
      
      
      
   }
   
   
   func getAttributedText(font:UIFont,text:String)->NSMutableAttributedString{
      print("kern fontSpaceSliderValue= \(fontSpace)")
      print("kern font.pointSize= \(font.pointSize)")
      let kernValue = fontSpace*(font.pointSize)
      print("kern  kernValue= \(kernValue)")
      
      let attributedString = NSMutableAttributedString(string: text)
      attributedString.addAttribute(NSAttributedString.Key.kern,
                                    value: kernValue,
                                    range: NSRange(location: 0, length: attributedString.length-1))
      
      attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attributedString.length))
      
      let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = NSTextAlignment.center
      
      attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length-1))
      
      return attributedString
   }
   
   
   private func allButtonInit(){
      editTextButton.layer.borderColor = UIColor.hexStringToUIColor(hex: "#06283D").cgColor
      editTextButton.layer.borderWidth = 2.0
      editTextButton.layer.cornerRadius = 4.0
   }
   
   @IBAction func fontOutlineSwitchAction(_ sender: Any) {
      switchInit()
   }
   
   
   @IBAction func fontStrokeSliderAction(_ sender: UISlider) {
      let value = CGFloat(sender.value)
      fontStrokeSliderLabel.text = "\(Int(value*100))"
      fontStrokeSliderValue = Float(value)
      curveLabel.strokeWidthChange(value: value)
      
   }
   
   
   @IBAction func fontSpaceSliderAction(_ sender: UISlider) {
      fontSpace = CGFloat(sender.value)
      let value = CGFloat(sender.value)
      
      fontSpaceSliderLabel.text = "\(Int(value*100))"
      
      if let font = curveLabel.font,let text = curveLabel.text{
         let ar = getAttributedText(font: font, text: text)
         //curveLabel.text = text
         curveLabel.attributedText = ar
      }
      curveText(value: CGFloat(sliderValue))
      
   }
   
   @IBAction func fontSliderAction(_ sender: UISlider) {
      
      fontSliderValue = sender.value
      let value = CGFloat(sender.value)
      fontSize = value
      fontSliderLabel.text = "\(Int(value))"
      let font = UIFont(name: fontName, size: fontSize)
      curveLabel.font = font
      
      circleDiameterCalculate()
      curveText(value: CGFloat(sliderValue))
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
   
   
   private func getTextSize(label:CurveUILabel?)->CGSize{
      guard let newLabel = label else {
         return CGSize(width: 0, height: 0)
      }
      let font = (newLabel.font) ?? UIFont.boldSystemFont(ofSize: CGFloat(24.0))
      
      let kernvalue = fontSpace*font.pointSize
      print("kern getTextSize = \(fontSpace) -- \(kernvalue)")
      
      let attributedString = NSMutableAttributedString(string: newLabel.text ?? " ")
      attributedString.addAttribute(NSAttributedString.Key.kern,
                                    value: kernvalue,
                                    range: NSRange(location: 0, length: attributedString.length-1))
      
      attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attributedString.length))
      
      let size  = CGSize(width: attributedString.size().width+kernvalue, height: attributedString.size().height)
      
      return size
   }
   
   private func circleDiameterCalculate(){
      let textFontSize = getTextSize(label: curveLabel)
      var diameter:CGFloat = ((textFontSize.width / (2 * .pi))*2)
      diameter += textFontSize.height*2
      circleDiameter = diameter
   }
   
   private func switchInit(){
      if fontOutlineSwitch.isOn{
         fontOutlineSwitchlabel.text = "Outline"
      } else {
         fontOutlineSwitchlabel.text = "Font"
      }
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
      
      
      fontSpaceSliderValue = Float(fontSpace)
      fontSpaceSlider.minimumValue = fontSpaceSliderMinValue
      fontSpaceSlider.maximumValue = fontSpaceSliderMaxValue
      fontSpaceSlider.value = fontSpaceSliderValue
      fontSpaceSliderLabel.text = "\(Int(fontSpaceSliderValue*100))"
      
      
      fontStrokeSlider.minimumValue = fontStrokeSliderMinValue
      fontStrokeSlider.maximumValue = fontStrokeSliderMaxValue
      fontStrokeSlider.value = fontStrokeSliderValue
      fontStrokeSliderLabel.text = "\(Int(fontStrokeSliderValue*100))"
      
      
      
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
         //print("start")
         break
      case .ended, .cancelled, .failed:
         //print("End")
         break
      case .changed:
         let center = CGPoint(x:self.curveLabel.center.x + translation.x, y: self.curveLabel.center.y + translation.y)
         curveLabel.center = center
         labelPreviousCenter = center
         
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
      let newConValue = ((convertedValue/30)*fontSize)
      curveLabel.sliderValue = newConValue
      curveLabel.fontSpace = fontSpace
      curveLabel.labelWidthCalculation()
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
         curveText(value: CGFloat(sliderValue))
      }
      
   }
}

extension TextCurveViewController:FontBarViewDelegate{
   func fontChange(fontName: String?) {
      if let fontName{
         self.fontName = fontName
         if let font  = UIFont(name: fontName, size: fontSize){
            curveLabel.font = font
            curveText(value: CGFloat(sliderValue))
         }
      }
      
   }
}

extension TextCurveViewController: UIGestureRecognizerDelegate {
   
   func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
      return false
   }
}

extension CGFloat {
   var degrees: CGFloat {
      return self * (180.0 / .pi)
   }
   
   var radians: CGFloat {
      return self / 180.0 * .pi
   }
   
}



extension TextCurveViewController:ColorBarviewDelegate{
   func selectedColor(color: UIColor) {
      
      if fontOutlineSwitch.isOn{
         curveLabel.strokeColorChange(color: color)
      } else {
         curveLabel.textColorChange(color: color)
      }
   }
   
   func selectedGradientColor(gColor:GradientColor) {
      
      if fontOutlineSwitch.isOn{
         curveLabel.strokeGradientColorChange(color: gColor)
      } else {
         curveLabel.textGradientColorChange(color: gColor)
      }
      
   }
}
