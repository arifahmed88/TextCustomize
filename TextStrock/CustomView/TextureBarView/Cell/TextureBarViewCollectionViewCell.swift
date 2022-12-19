//
//  TextureBarViewCollectionViewCell.swift
//  TextStrock
//
//  Created by PosterMaker on 12/13/22.
//

import UIKit

class TextureBarViewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
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
        
        imageView.frame = CGRect(origin: .zero, size: CGSize(width: bounds.height, height: bounds.height))
        imageView.center = CGPoint(x: bounds.width*0.5, y: bounds.height*0.5)
        
        imageView.layer.cornerRadius = radius
        //colorView.frame.height*0.5
        
        if isSelected{
            cellSelectedAction()
        }
        
    }
    
    func cellSelectedAction(){
        let insetvalue:CGFloat = 7.0
        imageView.frame = CGRect(origin: .zero, size: CGSize(width: bounds.width - (2*insetvalue), height: bounds.height - (2*insetvalue)))
        imageView.center = CGPoint(x: bounds.width*0.5, y: bounds.height*0.5)
        imageView.layer.cornerRadius = radius
        //colorView.frame.height*0.5
    }
    
}
