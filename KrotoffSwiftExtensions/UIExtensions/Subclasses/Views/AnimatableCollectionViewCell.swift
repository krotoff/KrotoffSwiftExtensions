//
//  AnimatableCollectionViewCell.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 20.02.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

open class AnimatableCollectionViewCell: UICollectionViewCell, Animatable {
    
    // MARK: - Public properties
    
    open var defaultShadowOpacity = Float()
    open var bounceScale: CGFloat = 0.9
    
    // MARK: - Animation
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        animateScaling(isBounced: true)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        animateScaling(isBounced: false)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        animateScaling(isBounced: false)
    }
}
