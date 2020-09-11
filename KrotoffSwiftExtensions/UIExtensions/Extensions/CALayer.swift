//
//  CALayer.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 17.02.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public extension CALayer {
    
    // MARK: - Public methods
    
    @discardableResult
    func applyShadow(
        color: UIColor = .black,
        offset: CGSize = .init(width: 0, height: 4),
        opacity: Float = 0.25,
        radius: CGFloat = 4
    ) -> Self {
        shadowColor = color.cgColor
        shadowOffset = offset
        shadowOpacity = opacity
        shadowRadius = radius
            
        return self
    }
    
    @discardableResult
    func applyCornerRadius(with radius: CGFloat) -> Self {
        masksToBounds = true
        
        return updateCornerRadius(with: radius)
    }
    
    @discardableResult
    func updateCornerRadius(with radius: CGFloat) -> Self {
        cornerRadius = radius
        
        return self
    }
    
    @discardableResult
    func updateRoundedShadowPath(roundedRect: CGRect, cornerRadius: CGFloat) -> Self {
        updateShadowPath(with: UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius).cgPath)
    }
    
    @discardableResult
    func updateShadowPath(with path: CGPath) -> Self {
        shadowPath = path
        
        return self
    }
}
