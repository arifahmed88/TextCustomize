//
//  UIFont+Extention.swift
//  TextStrock
//
//  Created by PosterMaker on 11/27/22.
//

import UIKit

extension UIFont{
    
    static func registerFontWithFilenameString(filenameString: String) {
        let pathForResourceString = Bundle.main.path(forResource: filenameString, ofType: nil)
        let fontData = NSData(contentsOfFile: pathForResourceString!)
        let dataProvider = CGDataProvider(data: fontData!)
        let fontRef = CGFont(dataProvider!)
        var errorRef: Unmanaged<CFError>? = nil
                
        if (CTFontManagerRegisterGraphicsFont(fontRef!, &errorRef) == false) {
          print("Failed to register font - \(filenameString)")
        }
    }
    
    static func loadFont(fontFileName: String) {
        registerFontWithFilenameString(filenameString: fontFileName)
    }
    
    class func loadAllFonts() {
        let docsPath = Bundle.main.resourcePath!
        let fileManager = FileManager.default

        do {
            NSLog("font loading: started")
            let docsArray = try fileManager.contentsOfDirectory(atPath: docsPath)
            let fontsNames = docsArray.filter { (fontName) -> Bool in
                if fontName.contains("ttf") || fontName.contains("TTF") || fontName.contains("otf") || fontName.contains("OTF") {
                    return true
                }
                return false
            }
            print("count of fonts: \(fontsNames.count)")
            for fontName in fontsNames {
                loadFont(fontFileName: fontName)
            }
            NSLog("font loading: finished")
        } catch {
          print(error)
        }
    }
}
