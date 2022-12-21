//
//  TextCurveViewController.swift
//  TextStrock
//
//  Created by PosterMaker on 12/18/22.
//

import UIKit
import SnapKit


class TextCurveViewController: UIViewController {

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
        testLabel.text = "This of the CurveText. I am Who I a'm"
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        sliderLabel.text = "\(Int(value))"
        
        testLabel.sliderValue = value
        testLabel.setNeedsDisplay()
        
    }
}
