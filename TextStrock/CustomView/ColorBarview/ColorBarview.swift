//
//  ColorBarview.swift
//  ImageColorPop
//
//  Created by PosterMaker on 11/23/22.
//

import UIKit

protocol ColorBarviewDelegate{
    func selectedColor(color:UIColor)
    func selectedGradientColor(gColor:GradientColor)
}

class ColorBarview: UIView {

    var collectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumInteritemSpacing = 15.0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    let collectionViewCellIdentifier = "colorBarCollectionViewCellIdentifier"
    var collectionViewPreviousSelectedIndex = IndexPath(item: 0, section: 0)
    
    var colorList = UIColorList()
    var gradientColorList = UIGradientColorList()
    var delegate:ColorBarviewDelegate?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetUp()
    }
    
    

    private func viewSetUp(){
        backgroundColor = .clear
        viewConstrainSet()
        collectionviewConfigure()
    }
    
    
    func viewConstrainSet(){
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
    }
    
    
    private func collectionviewConfigure(){
        let nib = UINib(nibName: "ColorBarCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: collectionViewCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


extension ColorBarview: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return gradientColorList.uiGradentColorList.count
        }
        return colorList.uiColorList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as! ColorBarCollectionViewCell
        
        var isSelected = false
        if indexPath == collectionViewPreviousSelectedIndex{
            isSelected = true
        }
        cell.setupCell(isSelected: isSelected)
        

        
        
        if indexPath.section == 0 {
            if indexPath.item >= gradientColorList.uiGradentColorList.count{
                cell.colorView.backgroundColor = .gray
            } else {
                let bColor = gradientColorList.uiGradentColorList[indexPath.item].getGradientUIColor(in: cell.frame)
                cell.colorView.backgroundColor = bColor
            }
            return cell
        }
        
        if indexPath.item >= colorList.uiColorList.count{
            cell.colorView.backgroundColor = .gray
        } else {
            cell.colorView.backgroundColor = colorList.uiColorList[indexPath.item]
        }
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let previousIndexPath = IndexPath(item: collectionViewPreviousSelectedIndex.item, section: collectionViewPreviousSelectedIndex.section)
        collectionViewPreviousSelectedIndex = indexPath
        
        collectionView.reloadItems(at: [previousIndexPath, indexPath])
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        

        if let currentCell = collectionView.cellForItem(at: indexPath) as? ColorBarCollectionViewCell{
            currentCell.cellSelectedAction()
            if indexPath.section == 0 {
                delegate?.selectedGradientColor(gColor: gradientColorList.uiGradentColorList[indexPath.item])
            } else {
                delegate?.selectedColor(color: colorList.uiColorList[indexPath.item])
            }
        }

    }
}



extension ColorBarview: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
    }
    
}



