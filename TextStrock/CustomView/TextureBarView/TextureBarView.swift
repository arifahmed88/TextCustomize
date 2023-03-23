//
//  TextureBarView.swift
//  TextStrock
//
//  Created by PosterMaker on 12/13/22.
//

import UIKit

protocol TextureBarViewDelegate{
    func selectedTexture(texture:Texture)
}

class TextureBarView: UIView {

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
    
    let collectionViewCellIdentifier = "textureBarCollectionViewCellIdentifier"
    var collectionViewPreviousSelectedIndex = IndexPath(item: -1, section: -1)
    
    var textTextures = TextTexture()
    var delegate:TextureBarViewDelegate?
    
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
        let nib = UINib(nibName: "TextureBarViewCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: collectionViewCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


extension TextureBarView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textTextures.backgrounds.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as! TextureBarViewCollectionViewCell
        
        var isSelected = false
        if indexPath == collectionViewPreviousSelectedIndex{
            isSelected = true
        }
        cell.setupCell(isSelected: isSelected)
        
        if indexPath.item >= textTextures.backgrounds.count{
            cell.imageView.image = UIImage(named: "w152")
           // cell.colorView.backgroundColor = .gray
        } else {
            let image = textTextures.backgrounds[indexPath.item].getImage() //colorList.uiGradentColorList[indexPath.item].getGradientUIColor(in: cell.frame)
            cell.imageView.image = image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let previousIndexPath = IndexPath(item: collectionViewPreviousSelectedIndex.item, section: collectionViewPreviousSelectedIndex.section)
        collectionViewPreviousSelectedIndex = indexPath
        
        collectionView.reloadItems(at: [previousIndexPath, indexPath])
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

        if let currentCell = collectionView.cellForItem(at: indexPath) as? TextureBarViewCollectionViewCell{
            currentCell.cellSelectedAction()
            delegate?.selectedTexture(texture: textTextures.backgrounds[indexPath.item])
        }

    }
}



extension TextureBarView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
    }
    
}




