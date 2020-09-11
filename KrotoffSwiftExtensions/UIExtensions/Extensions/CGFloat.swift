//
//  CGFloat.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 22.04.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public extension CGFloat {
    
    // MARK: - Public methods
    
    func height(
        forText text: String,
        font: UIFont,
        maxValue: CGFloat = .greatestFiniteMagnitude
    ) -> CGFloat {
        let constraintRect = CGSize(width: self, height: maxValue)
        let boundingBox = text.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )

        return ceil(boundingBox.height)
    }
    
    func width(
        forText text: String,
        font: UIFont,
        maxValue: CGFloat = .greatestFiniteMagnitude
    ) -> CGFloat {
        let constraintRect = CGSize(width: maxValue, height: self)
        let boundingBox = text.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )

        return ceil(boundingBox.width)
    }
}
