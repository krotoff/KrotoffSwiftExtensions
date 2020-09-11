//
//  TextFieldWithInsets.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 21.07.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public class TextFieldWithInsets: UITextField {
    
    // MARK: - Open properties
    
    open var insets: UIEdgeInsets
    
    // MARK: - Initialization

    public required init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        
        super.init(frame: .zero)
    }

    public required init(with inset: CGFloat) {
        insets = UIEdgeInsets(all: inset)
        
        super.init(frame: .zero)
    }

    public required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - UITextField methods
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds).insetBy(dx: insets.left, dy: insets.top + insets.bottom)
    }

    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return super.placeholderRect(forBounds: bounds).insetBy(dx: 0, dy: 0)
    }

    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: bounds).insetBy(dx: insets.left, dy: insets.top + insets.bottom)
    }

    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + insets.left + insets.right,
            height: size.height + insets.top + insets.bottom
        )
    }
}
