//
//  UIEdgeInsets.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 17.02.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public extension UIEdgeInsets {
    
    // MARK: - Initialization
    
    init(all: CGFloat) {
        self.init(top: all, left: all, bottom: all, right: all)
    }
    
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
