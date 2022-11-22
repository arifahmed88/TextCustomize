//
//  ViewController.swift
//  TextStrock
//
//  Created by PosterMaker on 11/20/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var strockSlider: UISlider!
    @IBOutlet weak var fontSlider: UISlider!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    var fontSize:Float = 60
    var strockSize:Float = 0
    var textColor = UIColor.white
    var strockColor = UIColor.red
    
    var customLabel = {
        var label = UILabel(frame: .zero)
        label.text = "ARIF AHMED"
        label.font = UIFont(name: "Optima-Regular", size: 40)
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        strockSlider.minimumValue = -10
        strockSlider.maximumValue = 10
        strockSlider.value = 0
        
        fontSlider.minimumValue = 10
        fontSlider.maximumValue = 100
        fontSlider.value = 60
        
        mainLabel.textColor = textColor
        mainLabel.font = mainLabel.font.withSize(CGFloat(fontSize))
        textColor = .blue
        
        customLabelAdd()
        
        
    }
    
    func customLabelAdd(){
        view.addSubview(customLabel)
    }
    
    
    @IBAction func strockSliderAction(_ sender: UISlider) {
        strockSize = strockSlider.value
        getAttributedText()
    }
    
    
    @IBAction func fontSliderAction(_ sender: UISlider) {
        fontSize = fontSlider.value
        getAttributedText()
    }
    
    func getAttributedText(){
        let font = mainLabel.font.withSize(CGFloat(fontSize))
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : strockColor,
            NSAttributedString.Key.foregroundColor : textColor,
            NSAttributedString.Key.strokeWidth : -strockSize,//-4.0
            NSAttributedString.Key.font : font]
            as [NSAttributedString.Key : Any]
        
        mainLabel.attributedText = NSMutableAttributedString(string: "Arif Ahmed", attributes: strokeTextAttributes)
    }

    

}

