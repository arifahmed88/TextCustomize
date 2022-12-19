//
//  TextTexture.swift
//  TextStrock
//
//  Created by PosterMaker on 12/13/22.
//

import UIKit

class Texture{
    var imageUrl:String
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
    
    func getImage()->UIImage?{
        let image = UIImage(contentsOfFile: imageUrl)
        return image
    }
    
    func getTextureUIColor(in rect: CGRect)->UIColor?{
        if let uIimage = UIImage(contentsOfFile: imageUrl){
            
            let maxSide:CGFloat = max(rect.height, rect.width)
            if let resizeImage =  uIimage.resizeImage(targetSize: CGSize(width: maxSide, height: maxSide)){
                return UIColor(patternImage: resizeImage)
            }
            return UIColor(patternImage: uIimage)
        }
        return nil
    }
    
}

class TextTexture{
    
    var textures:[Texture] = []
    init(){
        loadImagesFromBundel()
    }
    
    func loadImagesFromBundel(){
        let folderURL = Bundle.main.paths(forResourcesOfType: "jpg", inDirectory: nil)
        //print("folderURL = \(folderURL.count)")
        for item in folderURL {
            let texture = Texture(imageUrl: item)
            textures.append(texture)
            //print("folderURL = \(item)")
        }
    }
}
