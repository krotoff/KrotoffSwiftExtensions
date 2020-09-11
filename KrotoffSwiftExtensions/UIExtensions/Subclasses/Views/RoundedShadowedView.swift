//
//  RoundedShadowedView.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 31.01.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public class RoundedShadowedView: UIView {
    
    // MARK: - View lifecycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        updateRoundedShadowPath(roundedRect: bounds, cornerRadius: layer.cornerRadius)
    }
}
