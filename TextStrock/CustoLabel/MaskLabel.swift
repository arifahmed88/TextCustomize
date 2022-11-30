//
//  CustomLabelTemp.swift
//  TextStrock
//
//  Created by PosterMaker on 11/23/22.
//

import UIKit
final class MaskLabel: UILabel {

@IBInspectable var cornerRadius: CGFloat {
    get { return self.layer.cornerRadius }
    set { self.layer.cornerRadius = newValue }
}

@IBInspectable var borderWidth: CGFloat {
    get { return self.layer.cornerRadius }
    set { self.layer.borderWidth = newValue }
}

@IBInspectable var borderColor: UIColor {
    get { return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor) }
    set { self.layer.borderColor = newValue.cgColor }
}

@IBInspectable var insetTop: CGFloat {
    get { return self.textInsets.top }
    set { self.textInsets.top = newValue }
}

@IBInspectable var insetLeft: CGFloat {
    get { return self.textInsets.left }
    set { self.textInsets.left = newValue }
}

@IBInspectable var insetBottom: CGFloat {
    get { return self.textInsets.bottom }
    set { self.textInsets.bottom = newValue }
}

@IBInspectable var insetRight: CGFloat {
    get { return self.textInsets.right }
    set { self.textInsets.right = newValue }
}



// MARK: - Value
// MARK: Public
private var textInsets = UIEdgeInsets.zero
    private var originalBackgroundColor: UIColor? = .blue



// MARK: - Initializer
required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setLabelUI()
}

override init(frame: CGRect) {
    super.init(frame: frame)

    setLabelUI()
}

override func prepareForInterfaceBuilder() {
    setLabelUI()
}


// MARK: - Draw
override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: textInsets))
    guard let context = UIGraphicsGetCurrentContext() else { return }

    context.saveGState()
    context.setBlendMode(.clear)

    originalBackgroundColor?.setFill()
    UIRectFill(rect)

    super.drawText(in: rect)
    context.restoreGState()
}


// MARK: - Function
// MARK: Private
private func setLabelUI() {
    // cache (Before masking the label, the background color must be clear. So we have to cache it)
    originalBackgroundColor = backgroundColor
    backgroundColor = .clear

    layer.cornerRadius = cornerRadius
    layer.borderWidth  = borderWidth
    layer.borderColor  = borderColor.cgColor
}
}
