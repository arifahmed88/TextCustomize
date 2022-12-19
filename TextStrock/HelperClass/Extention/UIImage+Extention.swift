//
//  UIImage+Extention.swift
//  TextStrock
//
//  Created by PosterMaker on 12/13/22.
//

import UIKit

extension UIImage{
    
    func resizeImage(targetSize: CGSize) -> UIImage? {
        
        let maskImage = self
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let rect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        let image = renderer.image { (context) in
            maskImage.draw(in: rect)
        }
        return image

    }
    
}
