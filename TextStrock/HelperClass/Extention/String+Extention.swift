//
//  String+Extention.swift
//  TextStrock
//
//  Created by PosterMaker on 11/27/22.
//

import UIKit


extension String {
    func camelCaseToWords() -> String {
        return unicodeScalars.reduce("") {
            if CharacterSet.uppercaseLetters.contains($1) {
                return ($0 + " " + String($1))
            } else {
                return $0 + String($1)
            }
        }
    }
    
    func getCorrectFontName() -> String? {
        let dummyFontSize: CGFloat = 14
        
        let nameWithOutDesh = self.components(separatedBy: "-").joined(separator: " ")
        if UIFont(name: nameWithOutDesh, size: dummyFontSize) != nil {
            return nameWithOutDesh
        }
        // replace - with noSpace
        let nameDeshToNoSpace = self.components(separatedBy: "-").joined(separator: "")
        if UIFont(name: nameDeshToNoSpace, size: dummyFontSize) != nil {
            return nameDeshToNoSpace
        }
        
        // replace space to -
        let nameWithOutSpace = self.components(separatedBy: " ").joined(separator: "-")
        if UIFont(name: nameWithOutSpace, size: dummyFontSize) != nil {
            return nameWithOutSpace
        }
        
        // replace space with no space
        let noSpacedString = self.components(separatedBy: " ").joined(separator: "")
        if UIFont(name: noSpacedString, size: dummyFontSize) != nil {
            return noSpacedString
        }
        
        // replace camel case to spaced name
        let spacedCamelcaseString = self.camelCaseToWords().trimmingCharacters(in: .whitespacesAndNewlines)
        if UIFont(name: spacedCamelcaseString, size: dummyFontSize) != nil {
            return spacedCamelcaseString
        }
        
        // replace camel cased spaced with a desh
        let deshedCamelCasedString = spacedCamelcaseString.components(separatedBy: " ").joined(separator: "-")
        if UIFont(name: deshedCamelCasedString, size: dummyFontSize) != nil {
            return deshedCamelCasedString
        }
        
        if UIFont(name: self, size: dummyFontSize) != nil {
            return self
        }
        return nil
    }
    
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string

        return decoded ?? self
    }
}
