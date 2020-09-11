//
//  UIColor.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 17.01.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public extension UIColor {
    
    // MARK: - Initialization
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF)
    }
    
    convenience init(rgb: Int64) {
        self.init(rgb: Int(rgb))
    }
    
    convenience init?(string: String) {
        let nsString = string as NSString
        let int = nsString.integerValue
        
        self.init(rgb: int)
    }
}
