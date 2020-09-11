//
//  UIImage.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 21.07.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public extension UIImage {
    
    // MARK: - Public methods
    
    func scaled(fit fitSize: CGSize) -> UIImage {
        let size = self.size

        let widthRatio = fitSize.width / size.width
        let heightRatio = fitSize.height / size.height

        let scaleRatio = min(widthRatio, heightRatio)
        let newSize = CGSize(width: size.width * scaleRatio, height: size.height * scaleRatio)

        return scaled(to: newSize)
    }

    func scaled(to newSize: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)

        draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return newImage ?? self
    }
}
