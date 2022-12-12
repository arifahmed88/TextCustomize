//
//  ColorBarCollectionViewCell.swift
//  
//
//  Created by PosterMaker on 11/23/22.
//

import UIKit
import SnapKit


class ColorBarCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var colorView: UIView!
    
    let radius:CGFloat = 4.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setupCell(isSelected:Bool){
        self.layer.cornerRadius = radius
        
        let insetvalue:CGFloat = 1.0
        selectedView.frame = CGRect(origin: .zero, size: CGSize(width: bounds.width - (2*insetvalue), height: bounds.height - (2*insetvalue)))
        selectedView.center = CGPoint(x: bounds.width*0.5, y: bounds.height*0.5)
        
        selectedView.layer.borderColor = UIColor.gray.cgColor
        selectedView.layer.borderWidth = 2.0
        selectedView.layer.cornerRadius = radius
        //selectedView.frame.height*0.5
        
        colorView.frame = CGRect(origin: .zero, size: CGSize(width: bounds.height, height: bounds.height))
        colorView.center = CGPoint(x: bounds.width*0.5, y: bounds.height*0.5)
        
        colorView.layer.cornerRadius = radius
        //colorView.frame.height*0.5
        
        if isSelected{
            cellSelectedAction()
        }
        
    }
    
    func cellSelectedAction(){
        let insetvalue:CGFloat = 7.0
        colorView.frame = CGRect(origin: .zero, size: CGSize(width: bounds.width - (2*insetvalue), height: bounds.height - (2*insetvalue)))
        colorView.center = CGPoint(x: bounds.width*0.5, y: bounds.height*0.5)
        colorView.layer.cornerRadius = radius
        //colorView.frame.height*0.5
    }

}
