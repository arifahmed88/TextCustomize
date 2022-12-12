//
//  NibLoadeble.swift
//  TextStrock
//
//  Created by PosterMaker on 12/1/22.
//

import UIKit

public protocol NibLoadable {
    static var nibName: String { get }
}

public extension NibLoadable where Self: UIView {
    
    static var nibName: String {
        return String(describing: Self.self) // defaults to the name of the class implementing this protocol.
    }
    
    static var nib: UINib {
        let bundle = Bundle(for: Self.self)
        return UINib(nibName: Self.nibName, bundle: bundle)
    }
    
    func setupFromNib() {
        guard let view = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("Error loading \(self) from nib") }
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            view.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        } else {
            // Fallback on earlier versions
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        }
        if #available(iOS 11.0, *) {
            view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        } else {
            // Fallback on earlier versions
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        }
        if #available(iOS 11.0, *) {
            view.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        } else {
            // Fallback on earlier versions
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        }
        if #available(iOS 11.0, *) {
            view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        } else {
            // Fallback on earlier versions
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        }
    }
}
