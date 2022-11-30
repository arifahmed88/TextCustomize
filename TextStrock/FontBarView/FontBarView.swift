//
//  FontBarView.swift
//  TextStrock
//
//  Created by PosterMaker on 11/27/22.
//

import UIKit


protocol FontBarViewDelegate{
    func fontChange(fontName:String?)
}

class FontBarView: UIView {

    var collectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumInteritemSpacing = 10.0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    let collectionViewCellIdentifier = "fontBarCollectionViewCellIdentifier"
    var collectionViewPreviousSelectedIndex = 0
    
    var fontList = AllFonts.shared.availableFonts
    var delegate:FontBarViewDelegate?
    
    
    
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
        let nib = UINib(nibName: "FontBarCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: collectionViewCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


extension FontBarView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fontList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as! FontBarCollectionViewCell
        let font = fontList[indexPath.item]
        cell.setCell(text: font.fontName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let previousIndexPath = IndexPath(item: collectionViewPreviousSelectedIndex, section: 0)
        collectionView.reloadItems(at: [previousIndexPath, indexPath])
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionViewPreviousSelectedIndex = indexPath.item

        if let currentCell = collectionView.cellForItem(at: indexPath) as? FontBarCollectionViewCell{
            currentCell.cellSelectedAion()
            delegate?.fontChange(fontName: fontList[indexPath.item].fontName)
        }

    }
}



extension FontBarView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let font = fontList[indexPath.item]
        let fontName = font.fontName ?? " "
        
        let itemSize = fontName.size(withAttributes: [
            NSAttributedString.Key.font : UIFont(name: fontName, size: 16) ?? UIFont.boldSystemFont(ofSize: 16)
        ])
        
        
        return CGSize(width: itemSize.width+20, height: collectionView.bounds.height)
    }
    
}




