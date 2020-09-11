//
//  UIStackView.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 15.07.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public extension UIStackView {
    
    // MARK: - Initialization
    
    convenience init(
        arrangedSubviews: [UIView] = [],
        alignment: UIStackView.Alignment = .fill,
        axis: NSLayoutConstraint.Axis,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 0
    ) {
        self.init(arrangedSubviews: arrangedSubviews)
        
        self.alignment = alignment
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
    }
    
    // MARK: - Public methods
    
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { view in
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
