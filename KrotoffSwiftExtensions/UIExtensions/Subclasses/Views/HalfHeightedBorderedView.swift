//
//  HalfHeightedBorderedView.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 03.02.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public final class HalfHeightedBorderedView: UIView {
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }
    
    // MARK: - View lifecycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius(with: bounds.height / 2)
    }
    
    // MARK: - Private methods
    
    private func initialize() {
        layer.masksToBounds = true
        layer.borderWidth = 1
    }
}

