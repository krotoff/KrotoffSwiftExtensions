//
//  Animatable.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 20.02.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public protocol Animatable: UIView {
    var defaultShadowOpacity: Float { get }
    var bounceScale: CGFloat { get }
    
    func animateScaling(isBounced: Bool)
}
    
public extension Animatable {
    
    // MARK: - Public methods
    
    func animateScaling(isBounced: Bool) {
        let scaleTransform = isBounced ? CGAffineTransform(scaleX: bounceScale, y: bounceScale) : .identity
        let shadowOpacity = isBounced ? 0.1 : defaultShadowOpacity
        
        let timingParams = UISpringTimingParameters(damping: 0.4, response: 0.2)
        let animator = UIViewPropertyAnimator(duration: 0, timingParameters: timingParams)
        
        animator.addAnimations {
            self.transform = scaleTransform
            
            guard self.layer.shadowOpacity != shadowOpacity else { return }
            
            self.layer.shadowOpacity = shadowOpacity
        }
        
        animator.isInterruptible = true
        animator.startAnimation()
    }
}
