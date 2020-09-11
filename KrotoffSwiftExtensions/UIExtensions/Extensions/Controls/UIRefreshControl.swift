//
//  UIRefreshControl.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 28.04.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public extension UIRefreshControl {
    
    // MARK: - Public methods
    
    static func makeDefault(color: UIColor) -> UIRefreshControl {
        let control = UIRefreshControl()
        control.tintColor = color
        control.layer.zPosition = -1
        
        return control
    }
}
