//
//  BlendBarView.swift
//  TextStrock
//
//  Created by PosterMaker on 1/17/23.
//

import UIKit


protocol BlendBarViewDelegate{
    func blendModeChange(blendModeName:String?)
}

class BlendBarView: UIView {

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
    
    let collectionViewCellIdentifier = "fontBarCollectionViewCellIdentifier"
    
    var collectionViewPreviousSelectedIndex = IndexPath(item: 0, section: 0)
    
    var blendModes = {
        var modes:[String] = ["None"]
        var blendModes = CIFilter
            .filterNames(inCategory: nil)
            .filter { $0.contains("BlendMode")}
            .map {
                let capitalizedFilter = $0.dropFirst(2)
                let first = capitalizedFilter.first!
                return "\(first.lowercased())\(capitalizedFilter.dropFirst())"
            }
        var allBlendModes = modes + blendModes
        return allBlendModes
    }()

    var delegate:BlendBarViewDelegate?
    
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
        
        for mode in blendModes {
            print("\(mode) ")
        }
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
    
    func collectionViewReset(){
        collectionViewPreviousSelectedIndex = IndexPath(item: 0, section: 0)
        collectionView.reloadData()
    }
    
    
    private func collectionviewConfigure(){
        let nib = UINib(nibName: "FontBarCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: collectionViewCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}




extension BlendBarView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blendModes.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as! FontBarCollectionViewCell
//        cell.layer.borderWidth = 1.0
//        cell.layer.borderColor = UIColor.hexStringToUIColor(hex: "#FB2576").cgColor
        let blendMode = blendModes[indexPath.item]
        
        
        
        var isSelected = false
        if indexPath == collectionViewPreviousSelectedIndex{
            isSelected = true
        }
        
        let parsedMode = blendMode.replacingOccurrences(of: "BlendMode", with: "")
        cell.setCell(text: parsedMode, isSelected: isSelected)
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
            delegate?.blendModeChange(blendModeName: blendModes[indexPath.item])
        }

    }
    
}

extension BlendBarView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let text = blendModes[indexPath.item]
        let parsedText = text.replacingOccurrences(of: "BlendMode", with: "")
        
        let itemSize = parsedText.size(withAttributes: [
            NSAttributedString.Key.font : UIFont(name: "Quicksand-Medium", size: 16) ?? UIFont.boldSystemFont(ofSize: 16)
        ])
        
        return CGSize(width: itemSize.width+20, height: collectionView.bounds.height)
    }
    
}




