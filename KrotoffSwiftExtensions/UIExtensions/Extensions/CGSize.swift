//
//  CGSize.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 31.01.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public extension CGSize {
    
    // MARK: - Initialization
    
    init(side: CGFloat) {
        self.init(width: side, height: side)
    }
}
