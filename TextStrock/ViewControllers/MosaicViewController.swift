//
//  MosaicViewController.swift
//  TextStrock
//
//  Created by PosterMaker on 1/22/23.
//

import UIKit
import HandySwift
import HandyUIKit
import SnapKit
import AnimatedGradientView


public extension UIColor {
    func colorWithBrightness(brightness: CGFloat) -> UIColor {
        var H: CGFloat = 0, S: CGFloat = 0, B: CGFloat = 0, A: CGFloat = 0
        
        if getHue(&H, saturation: &S, brightness: &B, alpha: &A) {
            B += (brightness - 1.0)
            B = max(min(B, 1.0), 0.0)
            
            return UIColor(hue: H, saturation: S, brightness: B, alpha: A)
        }
        
        return self
    }
}

class MosaicViewController: UIViewController {
    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var filterBarView: BlendBarView!
    @IBOutlet weak var promoView: UIView!
    
//    let magnifyingGlass = MagnifyingGlassView(offset: CGPoint(x: 0.0, y: 0.0), radius: 60.0, scale: 4.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureAddInPixlatedView()
        
//        let today = Date()
//        print(today)
//        let modifiedDate = Calendar.current.date(byAdding: .day, value: 3, to: today)!
//        print(modifiedDate)
//
//        let time = today.timeIntervalSince(modifiedDate)
//        print(time)
        
//        let today = Date()
//
//        guard let expiredDate = Calendar.current.date(byAdding: .day, value: 3, to: today) else {return}
//
//        UserDefaults.standard.set(expiredDate.timeIntervalSince1970, forKey: "freetrialExpireDateKey")
//
//
//
//
//        let temp = UserDefaults.standard.double(forKey: "freetrialExpireDateKey")
//        print("temp = \(temp)")
//
//        let userDefaultDoubleValue = UserDefaults.standard.double(forKey: "freetrialExpireDateKey")
//        let freeTrialExpireDate = Date(timeIntervalSince1970: userDefaultDoubleValue)
//
//        print("ar = \(freeTrialExpireDate)")
//
        
        
        //
        guard let image = UIImage(named: "w162.jpg") else {return}
        let color = UIColor(patternImage: image)
        
//        let rgbaColor = UIColor(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.4)
////        rgbaColor.rgb
//        let hlcaColor = UIColor(hue: 180/360, saturation: 30/100, brightness: 125/128, alpha: 1)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        promoviewAnimationadd()
    }
    


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        filterBarView.collectionView.reloadData()
//        magnifyingGlass.magnifiedView = canvasView
//        magnifyingGlass.magnify(at: CGPoint(x: 150, y: 400))
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let location = touches.first!.location(in: canvasView)
//        magnifyingGlass.magnifiedView = canvasView
//        magnifyingGlass.magnify(at: location)
//    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let location = touches.first!.location(in: canvasView)
//
//        magnifyingGlass.magnify(at: location)
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
////        magnifyingGlass.magnifiedView = nil
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
////        magnifyingGlass.magnifiedView = nil
//    }
    
    
    private func promoviewAnimationadd(){
        let cornerRadius = CGFloat(8.0)
        promoView.clipsToBounds = true
        promoView.layer.cornerRadius = cornerRadius
        let offset = CGFloat(4)
        let gFrame = CGRect(x: offset, y: offset, width: promoView.bounds.width-2*offset, height: promoView.bounds.height-2*offset)
        
        let animatedGradient = AnimatedGradientView(frame: gFrame)
        animatedGradient.direction = .up
        animatedGradient.animationValues = [(colors: ["#46D8FF", "#CA53FF"], .up, .axial),(colors: ["#46D8FF", "#CA53FF","#46D8FF"], .right, .axial),(colors: ["#CA53FF", "#46D8FF"], .down, .axial),(colors: ["#CA53FF", "#46D8FF","#CA53FF"], .left, .axial)]
        
        animatedGradient.animationDuration = 1
        animatedGradient.autoAnimate = true
        animatedGradient.autoRepeat = true
        animatedGradient.clipsToBounds = true
        animatedGradient.layer.cornerRadius = cornerRadius
        promoView.insertSubview(animatedGradient, at: 0)
        animatedGradient.startAnimating()
        
        
        let moffset = offset + 10
        let mFrame = CGRect(x: moffset, y: moffset, width: promoView.bounds.width-2*moffset, height: promoView.bounds.height-2*moffset)
        
        let middleView = UIView(frame: mFrame)
        middleView.backgroundColor = UIColor.hexStringToUIColor(hex: "#051323")
        middleView.clipsToBounds = true
        middleView.layer.cornerRadius = cornerRadius-1.0
        promoView.insertSubview(middleView, aboveSubview: animatedGradient)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        guard let image = UIImage(named: "w162.jpg") else {return}
        let color = UIColor(patternImage: image)
        
        let a = color.change(.brightness, to: CGFloat(sender.value))
    }
    
    func gestureAddInPixlatedView(){
        let panGesture = UIPanGestureRecognizer(target: self,action:#selector(panGestureAction(gesture:)))
        canvasView.addGestureRecognizer(panGesture)
    }
    
    @objc func panGestureAction(gesture: UIPanGestureRecognizer) {
        guard let gestureView = gesture.view else {return}
        let translation = gesture.translation(in: gestureView)
        switch gesture.state {
        case .began:
//            magnifyingGlass.magnifiedView = canvasView
//            magnifyingGlass.magnify(at: magnifyingGlass.center)
            break
        case .changed:
//            let point = CGPoint(x:magnifyingGlass.center.x + translation.x, y: magnifyingGlass.center.y + translation.y)
//            magnifyingGlass.magnify(at: point)
//            let point = CGPoint(x:pixlatedView.center.x + translation.x, y: pixlatedView.center.y + translation.y)
//            pixlatedView.center = point
            break
            
        default:
            break
        }
        gesture.setTranslation(CGPoint.zero, in: gestureView)
    }


}
