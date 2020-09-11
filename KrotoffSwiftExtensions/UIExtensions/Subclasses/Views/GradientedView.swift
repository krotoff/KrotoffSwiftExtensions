//
//  GradientedView.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 13.03.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public class GradientedView: UIView {
    
    // MARK: - Private properties
    
    private var gradientLayer: CAGradientLayer!
    
    // MARK: - View lifecycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
    
    // MARK: - Internal methods
    
    public func configure(
        colors: [UIColor],
        points: (startPoint: CGPoint, endPoint: CGPoint) = (CGPoint(x: 0.5, y: 0), CGPoint(x: 0.5, y: 1))
    ) {
        gradientLayer = makeGradient(with: colors)
        layer.addSublayer(gradientLayer)
        layoutSubviews()
    }
    
    // MARK: - Private methods
    
    private func makeGradient(with colors: [UIColor]) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        
        return gradient
    }
}
