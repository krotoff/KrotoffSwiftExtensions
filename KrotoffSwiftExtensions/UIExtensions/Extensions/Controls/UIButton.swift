//
//  UIButton.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 20.02.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public extension UIButton {
    
    // MARK: - Public methods
    
    func setImage(_ image: UIImage?) {
        [.normal, .highlighted, .selected].forEach { setImage(image, for: $0) }
    }
}
