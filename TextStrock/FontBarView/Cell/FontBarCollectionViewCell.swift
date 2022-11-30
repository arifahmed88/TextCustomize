//
//  FontBarCollectionViewCell.swift
//  TextStrock
//
//  Created by PosterMaker on 11/27/22.
//

import UIKit

class FontBarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    let color = UIColor(red: 133/255, green: 133/255, blue: 133/255, alpha: 1.0)
    let selectedColor = UIColor.hexStringToUIColor(hex: "#FB2576")
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    func setCell(text:String?){
        let fontname = text ?? "arif"
        label.text = fontname
        label.textColor = color
        label.font = UIFont(name: fontname, size: 16) ?? UIFont.boldSystemFont(ofSize: 16)
    }
    
    func cellSelectedAion(){
        label.textColor = selectedColor
    }

}
