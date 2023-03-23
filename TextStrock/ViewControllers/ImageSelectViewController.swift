//
//  ImageSelectViewController.swift
//  TextStrock
//
//  Created by PosterMaker on 1/18/23.
//

import UIKit

protocol ImageSelectViewControllerDelegate{
    func selectedImage(image:UIImage?,isForBG:Bool)
}

class ImageSelectViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var photosButton: UIButton!
    
    var collectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 15.0
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    
    let collectionViewCellIdentifier = "textureBarCollectionViewCellIdentifier"
    var collectionViewPreviousSelectedIndex = IndexPath(item: -1, section: -1)
    
    var textTextures = TextTexture()
    var delegate:ImageSelectViewControllerDelegate?
    var picker:UIImagePickerController = UIImagePickerController()
    var isFromBG = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionviewConfigure()
        viewConstrainSet()
        picker.delegate = self
    }
    
    func viewConstrainSet(){
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.backButton.snp.bottom).offset(10)
            make.bottom.equalTo(self.view.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
    }
    
    private func collectionviewConfigure(){
        let nib = UINib(nibName: "TextureBarViewCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: collectionViewCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func photosButtonAction(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func dismissViewController(image:UIImage?,isAnimate:Bool = true){
        self.delegate?.selectedImage(image: image,isForBG: self.isFromBG)
        dismiss(animated: isAnimate)
    }
}



extension ImageSelectViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFromBG{
            return textTextures.backgrounds.count
        }
        return textTextures.textures.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as! TextureBarViewCollectionViewCell
        
        var isSelected = false
        if indexPath == collectionViewPreviousSelectedIndex{
            isSelected = true
        }
        cell.setupCell(isSelected: isSelected)
        
        let images:[Texture]
        if isFromBG{
            images =  textTextures.backgrounds
        } else {
            images = textTextures.textures
        }
        
        
        if indexPath.item >= images.count{
            cell.imageView.image = UIImage(named: "w152")
           // cell.colorView.backgroundColor = .gray
        } else {
            let image = images[indexPath.item].getImage() //colorList.uiGradentColorList[indexPath.item].getGradientUIColor(in: cell.frame)
            cell.imageView.image = image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let images:[Texture]
        if isFromBG{
            images =  textTextures.backgrounds
        } else {
            images = textTextures.textures
        }
        
        let image = UIImage(contentsOfFile: images[indexPath.item].imageUrl)
        dismissViewController(image: image)
    }
}



extension ImageSelectViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width*0.5 - 20
        
        return CGSize(width: width, height: width)
    }
    
}



extension ImageSelectViewController:UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("error")
            return
        }
        
        dismiss(animated: true,completion: {
            self.dismissViewController(image: image,isAnimate: true)
        })
    }
     
}
