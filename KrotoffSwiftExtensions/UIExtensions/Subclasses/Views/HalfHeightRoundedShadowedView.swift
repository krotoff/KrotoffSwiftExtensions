//
//  HalfHeightRoundedShadowedView.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 31.01.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public class HalfHeightRoundedShadowedView: RoundedShadowedView {
    
    // MARK: - View lifecycle
    
    public override func layoutSubviews() {
        updateCornerRadius(with: bounds.height / 2)
        
        super.layoutSubviews()
    }
}

