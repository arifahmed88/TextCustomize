//
//  TextCustomBoundViewController.swift
//  TextStrock
//
//  Created by PosterMaker on 9/10/23.
//

import UIKit

class TextCustomBoundViewController: UIViewController {
    
    enum BorderSide:String{
        case left = "Left"
        case right = "Right"
        case none = "None"
    }
    
    @IBOutlet weak var labelHolderView: SelectionBorderView!
    @IBOutlet weak var gestureView: UIView!
    @IBOutlet weak var label: UILabel!
    
    var gestureStartPoint = CGPoint()
    private var panGestureRecognizer:TouchDownPanGestureRecognizer?
    
    var selectedSide:BorderSide = .none
    var labelSize = CGSize()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewInit()
    }
    
    func viewInit(){
        label.backgroundColor = .clear
        
        let center = CGPoint(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height*0.5)
        let offset:CGFloat = 15.0
        
        labelHolderView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(label.snp.height).offset(offset*2)
            make.width.equalTo(label.snp.width).offset(offset*2)
            make.centerX.equalTo(center.x)
            make.centerY.equalTo(center.y)
        }
        
        
        label.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(labelHolderView.snp.centerX)
            make.centerY.equalTo(labelHolderView.snp.centerY)
        }
        
        
        panGestureRecognizer = TouchDownPanGestureRecognizer(target: self, action: #selector(pan(_ :)))
        if let panGestureRecognizer = panGestureRecognizer{
            panGestureRecognizer.minimumNumberOfTouches = 1
            panGestureRecognizer.maximumNumberOfTouches = 1
            panGestureRecognizer.delegate = self
            gestureView.addGestureRecognizer(panGestureRecognizer)
        }
        
        
    }

    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    var rightPanDirectionFlag:CGFloat = 1
    var leftPanDirectionFlag:CGFloat = -1
    
    @objc func pan(_ gestureRecognizer:TouchDownPanGestureRecognizer) {
        //if selectedSide == .none {return}
        let gView = gestureRecognizer.view
        switch gestureRecognizer.state{
        case .began:
            switch selectedSide{
            case .left:
                labelHolderView.leftViewSelect()
                break
            case .right:
                labelHolderView.rightViewSelect()
                break
            case .none:
                labelHolderView.rightViewDeselect()
                labelHolderView.leftViewDeselect()
                break
            }
            break
        case .changed:
            let tValue = (gestureRecognizer.velocity(in: gestureView).x/50)
           
            let size = getTextSize(newLabel: label)
            let labelPreviousSize = label.frame.size
            
            switch selectedSide{
            case .left:
                labelHolderView.rightCircelView.isUserInteractionEnabled = false
                let valueW = tValue*leftPanDirectionFlag
                let valueH = tValue*leftPanDirectionFlag
                var newWidth = labelPreviousSize.width + valueW
                var newHeight = labelPreviousSize.height - valueH
                
                
                if newHeight <= size.height{
                    newHeight = size.height
                }
                
                if newWidth >= size.width{
                    newHeight = size.height
                }
                
                let singleCharW = (getTextSize(newLabel: label,text: "a").width-8)*0.5
                if newWidth < (singleCharW){
                    newWidth = (singleCharW+8)
                    leftPanDirectionFlag *= (-1.0)
                }
                
                
                label.snp.remakeConstraints { (make) -> Void in
                    make.height.equalTo(newHeight)
                    make.width.equalTo(newWidth)
                    make.centerX.equalTo(labelHolderView.snp.centerX)
                    make.centerY.equalTo(labelHolderView.snp.centerY)
                }
                labelHolderView.setNeedsDisplay()
                view.layoutIfNeeded()
                
                break
            case .right:
                labelHolderView.leftCircelView.isUserInteractionEnabled = false
                let valueW = tValue*rightPanDirectionFlag
                let valueH = tValue*rightPanDirectionFlag
                
                var newWidth = labelPreviousSize.width + valueW
                var newHeight = labelPreviousSize.height - valueH
                
                if newHeight < size.height{
                    newHeight = size.height
                }
                
                if newWidth > size.width{
                    newHeight = size.height
                }
                
                let singleCharW = (getTextSize(newLabel: label,text: "a").width-8)*0.5
                if newWidth < (singleCharW){
                    newWidth = (singleCharW)
                    rightPanDirectionFlag *= -1
                }
                label.snp.remakeConstraints { (make) -> Void in
                    make.height.equalTo(newHeight)
                    make.width.equalTo(newWidth)
                    make.centerX.equalTo(labelHolderView.snp.centerX)
                    make.centerY.equalTo(labelHolderView.snp.centerY)
                }
                labelHolderView.setNeedsDisplay()
                view.layoutIfNeeded()
                break
            case .none:
//                let translation = gestureRecognizer.translation(in: gView)
//                let center = CGPoint(x: labelHolderView.center.x+translation.x, y: labelHolderView.center.y+translation.y)
//
//                let size = labelHolderView.frame.size
//                labelHolderView.snp.remakeConstraints { (make) -> Void in
//                    make.height.equalTo(size.height)
//                    make.width.equalTo(size.width)
//                    make.centerX.equalTo(center.x)
//                    make.centerY.equalTo(center.y)
//                }
//                labelHolderView.setNeedsDisplay()
                break
            }
            break
        default:
            labelHolderView.rightCircelView.isUserInteractionEnabled = true
            labelHolderView.leftCircelView.isUserInteractionEnabled = true
            
            rightPanDirectionFlag = 1
            leftPanDirectionFlag = -1
            
            switch selectedSide{
            case .left:
                labelHolderView.leftViewDeselect()
                break
            case .right:
                labelHolderView.rightViewDeselect()
                break
            case .none:
                labelHolderView.rightViewDeselect()
                labelHolderView.leftViewDeselect()
                break
            }
            
            break
        }
        
        gestureRecognizer.setTranslation(CGPoint.zero, in: gView)
        
    }
    

    @IBAction func sliderAction(_ sender: UISlider) {
        let value = CGFloat(sender.value*220)
        let size = getTextSize(newLabel: label)
        print(value)
        
        var newWidth = size.width + value + 8
        var newHeight = size.height - value
        if newHeight < size.height{
            newHeight = size.height
        }
        let singleCharW = getTextSize(newLabel: label,text: "a").width-8
        if newWidth < (singleCharW){
            newWidth = (singleCharW)
        }
        
        
        label.snp.remakeConstraints { (make) -> Void in
            make.height.equalTo(newHeight)
            make.width.equalTo(newWidth)
            make.centerX.equalTo(labelHolderView.snp.centerX)
            make.centerY.equalTo(labelHolderView.snp.centerY)
        }
        
        
        labelHolderView.setNeedsDisplay()
        view.layoutIfNeeded()
    }
    
    
    private func getTextSize(newLabel:UILabel,text:String? = nil)->CGSize{
        let font = (newLabel.font) ?? UIFont.boldSystemFont(ofSize: CGFloat(24.0))
        let kernvalue = 0.0
        let txt:String
        if text != nil{
           txt = text!
        } else {
            txt = newLabel.text ?? " "
        }
        
        let attributedString = NSMutableAttributedString(string: txt)
        attributedString.addAttribute(NSAttributedString.Key.kern,
                                      value: kernvalue,
                                      range: NSRange(location: 0, length: attributedString.length-1))
        
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attributedString.length))
        
        let size  = CGSize(width: attributedString.size().width+8, height: attributedString.size().height+8)
        
        return size
    }
    
    
    
}



extension TextCustomBoundViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        guard let gView = gestureRecognizer.view else {return true}
        let touchPoint = touch.location(in: gView)
        let convertedPoint = gView.convert(touchPoint, to: labelHolderView)
//        print("oni touchPoint \(touchPoint)")
//        print("oni convertedPoint \(convertedPoint)")
        
        
        if boundCheck(size: labelHolderView.bounds.size, checkPoint: convertedPoint){
            if labelHolderView.leftCircelView.frame.contains(convertedPoint){
                selectedSide = .left
            } else if labelHolderView.rightCircelView.frame.contains(convertedPoint){
                selectedSide = .right
            } else {
                selectedSide = .none
            }
//            print("oni inside")
        } else {
            selectedSide = .none
//            print("oni outside")
        }
       
//        print("oni selectedSide-- \(selectedSide)")
        
        gestureStartPoint = CGPoint(x: touchPoint.x, y: touchPoint.y)
        return true
    }
    
    private func boundCheck(size:CGSize,checkPoint:CGPoint)->Bool{
        if (checkPoint.x >= 0 && checkPoint.x <= size.width) && (checkPoint.y >= 0 && checkPoint.y <= size.height){
            return  true
        } else {
            return false
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    

//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
//             shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//       // Don't recognize a single tap until a double-tap fails.
////        if gestureRecognizer == self.tapGesture &&
////                  otherGestureRecognizer == self.doubleTapGesture
//
//       if gestureRecognizer == self.pinchGestureRecognizer &&
//              otherGestureRecognizer == self.panGestureRecognizer {
//          return true
//       }
//       return false
//    }
    
    
}
