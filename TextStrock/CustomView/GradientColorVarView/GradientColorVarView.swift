//
//  GradientColorVarView.swift
//  TextStrock
//
//  Created by PosterMaker on 11/29/22.
//

import UIKit

protocol GradientColorVarViewDelegate{
    func selectedGradientColor(gColor:GradientColor)
}

class GradientColorVarView: UIView {

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
    var collectionViewPreviousSelectedIndex = 0
    
    var colorList = UIGradientColorList()
    var delegate:GradientColorVarViewDelegate?
    
    
    
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


extension GradientColorVarView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.uiGradentColorList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as! ColorBarCollectionViewCell
        cell.setupCell(isSelected: false)
        if indexPath.item >= colorList.uiGradentColorList.count{
            cell.colorView.backgroundColor = .gray
        } else {
            let bColor = colorList.uiGradentColorList[indexPath.item].getGradientUIColor(in: cell.frame)
            cell.colorView.backgroundColor = bColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let previousIndexPath = IndexPath(item: collectionViewPreviousSelectedIndex, section: 0)
        collectionView.reloadItems(at: [previousIndexPath, indexPath])
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionViewPreviousSelectedIndex = indexPath.item

        if let currentCell = collectionView.cellForItem(at: indexPath) as? ColorBarCollectionViewCell{
            currentCell.cellSelectedAction()
            delegate?.selectedGradientColor(gColor: colorList.uiGradentColorList[indexPath.item])
        }

    }
}



extension GradientColorVarView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
    }
    
}




