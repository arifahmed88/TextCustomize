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
    
    var collectionViewPreviousSelectedIndex = IndexPath(item: 0, section: 0)
    
    var fontList = AllFonts.shared.availableFonts
    var delegate:FontBarViewDelegate?
    
    var selectedIndexPath: IndexPath?
    
    
    
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
        
        
        var isSelected = false
        if indexPath == collectionViewPreviousSelectedIndex{
            isSelected = true
        }
        cell.setCell(text: font.fontName, isSelected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let previousIndexPath = IndexPath(item: collectionViewPreviousSelectedIndex.item, section: collectionViewPreviousSelectedIndex.section)
        collectionViewPreviousSelectedIndex = indexPath

        collectionView.reloadItems(at: [previousIndexPath, indexPath])
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        //selectedIndexPath = indexPath

        if let currentCell = collectionView.cellForItem(at: indexPath) as? FontBarCollectionViewCell{
            currentCell.cellSelectedAction()
            delegate?.fontChange(fontName: fontList[indexPath.item].fontName)
        }

    }
}



//extension FontBarView: UICollectionViewDelegate {
//    
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        guard let centerIndexPath = getCenterIndex(),
//            let selectedIndex = selectedIndexPath,
//            centerIndexPath.item != selectedIndex.item else { return }
//        
//        
//        
//        let previousIndexPath = IndexPath(item: collectionViewPreviousSelectedIndex, section: 0)
//        collectionView.reloadItems(at: [previousIndexPath, centerIndexPath])
//        collectionView.scrollToItem(at: centerIndexPath, at: .centeredHorizontally, animated: true)
//        collectionViewPreviousSelectedIndex = centerIndexPath.item
//        selectedIndexPath = centerIndexPath
//
//        if let currentCell = collectionView.cellForItem(at: centerIndexPath) as? FontBarCollectionViewCell{
//            currentCell.cellSelectedAion()
//            delegate?.fontChange(fontName: fontList[centerIndexPath.item].fontName)
//        }
//        
//    }
//
//
//
//    private func getCenterIndex() -> IndexPath? {
//        let contentOffsetX = collectionView.contentOffset.x
//        if contentOffsetX <= 0 {
//            let indexPath = IndexPath(item: 0, section: 0)
//            return indexPath
//        }
//
//        if contentOffsetX >= (collectionView.contentSize.width - collectionView.bounds.width) {
//            let indexPath = IndexPath(item: AllFonts.shared.availableFonts.count-1, section: 0)
//            return indexPath
//        }
//
//
//        let center = self.convert(self.collectionView.center, to: self.collectionView)
//        if let index = collectionView.indexPathForItem(at: center) {
//            return index
//        }
//
//        let multiplier: CGFloat = 3
//        var thresholdCheck: CGFloat = 1
//        while (thresholdCheck <= 50) {
//            let modifiedCenter = CGPoint(x: center.x + (multiplier * thresholdCheck),
//                                         y: center.y)
//            if let centerIndexPath = collectionView.indexPathForItem(at: modifiedCenter) {
//                return centerIndexPath
//            }
//            thresholdCheck+=1
//        }
//
//        return nil
//    }
//}



























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




