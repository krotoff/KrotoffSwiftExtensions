//
//  UIView.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 22.01.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public extension UIView {
    
    // MARK: - Public properties
    
    // MARK: Interface
    
    var isDarkMode: Bool {
        if #available(iOS 12.0, *) {
            return traitCollection.userInterfaceStyle == .dark
        } else {
            return false
        }
    }
    
    // MARK: - Public types
    
    enum Axis { case x, y, all }
    
    // MARK: - Public methods
    
    // MARK: CALayer (Shadow, CornerRadius, and etc.)
    
    @discardableResult
    func applyShadow(
        color: UIColor = .black,
        offset: CGSize = CGSize(width: 0, height: 4),
        opacity: Float = 0.25,
        radius: CGFloat = 4
    ) -> Self {
        layer.applyShadow(color: color, offset: offset, opacity: opacity, radius: radius)
        
        return self
    }
    
    @discardableResult
    func applyCornerRadius(with radius: CGFloat) -> Self {
        layer.applyCornerRadius(with: radius)
        
        return self
    }
    
    @discardableResult
    func updateCornerRadius(with radius: CGFloat) -> Self {
        layer.updateCornerRadius(with: radius)
        
        return self
    }
    
    @discardableResult
    func updateRoundedShadowPath(roundedRect: CGRect, cornerRadius: CGFloat) -> Self {
        layer.updateRoundedShadowPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
        
        return self
    }
    
    @discardableResult
    func updateShadowPath(with path: CGPath) -> Self {
        layer.updateShadowPath(with: path)
        
        return self
    }
    
    // MARK: NSLayout (Constraints)
    
    @discardableResult
    func applyConstraintsInSuperview(at edges: UIRectEdge = .all, with insets: UIEdgeInsets = .zero, useSafeArea: Bool = false) -> Self {
        applyConstraints(in: superview!, at: edges, with: insets, useSafeArea: useSafeArea)
    }
    
    @discardableResult
    func applyConstraints(
        in view: UIView,
        at edges: UIRectEdge = .all,
        with insets: UIEdgeInsets = .zero,
        useSafeArea: Bool = false
    ) -> Self {
        if edges.contains(.left) { applyLeftConstraint(to: view, inset: insets.left, useSafeArea: useSafeArea) }
        if edges.contains(.top) { applyTopConstraint(to: view, inset: insets.top, useSafeArea: useSafeArea) }
        if edges.contains(.right) { applyRightConstraint(to: view, inset: insets.right, useSafeArea: useSafeArea) }
        if edges.contains(.bottom) { applyBottomConstraint(to: view, inset: insets.bottom, useSafeArea: useSafeArea) }
            
        return self
    }
    
    @discardableResult
    func applyLeftSpacingConstraint(to view: UIView, with inset: CGFloat = .zero, useSafeArea: Bool = false) -> Self {
        applyLeftConstraint(to: view, isAlign: false, inset: inset, useSafeArea: useSafeArea)
            
        return self
    }
    
    @discardableResult
    func applyRightSpacingConstraint(to view: UIView, with inset: CGFloat = .zero, useSafeArea: Bool = false) -> Self {
        applyRightConstraint(to: view, isAlign: false, inset: inset, useSafeArea: useSafeArea)
            
        return self
    }
    
    @discardableResult
    func applyTopSpacingConstraint(to view: UIView, with inset: CGFloat = .zero, useSafeArea: Bool = false) -> Self {
        applyTopConstraint(to: view, isAlign: false, inset: inset, useSafeArea: useSafeArea)
            
        return self
    }
    
    @discardableResult
    func applyBottomSpacingConstraint(to view: UIView, with inset: CGFloat = .zero, useSafeArea: Bool = false) -> Self {
        applyBottomConstraint(to: view, isAlign: false, inset: inset, useSafeArea: useSafeArea)
            
        return self
    }
    
    @discardableResult
    func applyCenterConstraints(to view: UIView, at axis: Axis = .all, with offset: CGPoint = .zero, useSafeArea: Bool = false) -> Self {
        switch axis {
        case .all:
            applyCenterXConstraint(to: view, offset: offset.x, useSafeArea: useSafeArea)
            applyCenterYConstraint(to: view, offset: offset.y, useSafeArea: useSafeArea)
        case .x:
            applyCenterXConstraint(to: view, offset: offset.x, useSafeArea: useSafeArea)
        case .y:
            applyCenterYConstraint(to: view, offset: offset.y, useSafeArea: useSafeArea)
        }
        
        return self
    }
    
    @discardableResult
    func applyEqualSizeConstraintsWithSuperview(at axis: Axis = .all, multiplier: CGSize = .zero, constant: CGSize = .zero) -> Self {
        applyEqualSizeConstraints(with: superview!, at: axis, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    func applyEqualSizeConstraints(with view: UIView, at axis: Axis = .all, multiplier: CGSize = .zero, constant: CGSize = .zero) -> Self {
        switch axis {
        case .all:
            applyEqualHeightConstraint(with: view, multiplier: multiplier.height, constant: constant.height)
            applyEqualWidthConstraint(with: view, multiplier: multiplier.width, constant: constant.width)
        case .x:
            applyEqualWidthConstraint(with: view, multiplier: multiplier.width, constant: constant.width)
        case .y:
            applyEqualHeightConstraint(with: view, multiplier: multiplier.height, constant: constant.height)
        }
        
        return self
    }
    
    @discardableResult
    func applySizeConstantConstraints(at axis: Axis = .all, with size: CGSize = .zero) -> Self {
        switch axis {
        case .all:
            applyHeightConstraint(size: size.height)
            applyWidthConstraint(size: size.width)
        case .x:
            applyWidthConstraint(size: size.width)
        case .y:
            applyHeightConstraint(size: size.height)
        }
        
        return self
    }
    
    /// - Parameters:
    ///   - multiplier: The multiplier of `height` on `width`. For example, `0.5` is for `height` equals half of `width`. `default` value is `1`.
    @discardableResult
    func applyAspectRatio(with multiplier: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: multiplier).isActive = true
        
        return self
    }
    
    // MARK: - Private methods
    
    // MARK: Alignment Constraints
    
    private func applyLeftConstraint(to view: UIView, isAlign: Bool = true, inset: CGFloat = .zero, useSafeArea: Bool) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let targetAnchor: NSLayoutXAxisAnchor
            
        if isAlign {
            targetAnchor = useSafeArea ? view.safeAreaLayoutGuide.leftAnchor : view.leftAnchor
        } else {
            targetAnchor = useSafeArea ? view.safeAreaLayoutGuide.rightAnchor : view.rightAnchor
        }
            
        leftAnchor.constraint(equalTo: targetAnchor, constant: isAlign ? inset : -inset).isActive = true
    }
    
    private func applyTopConstraint(to view: UIView, isAlign: Bool = true, inset: CGFloat = .zero, useSafeArea: Bool) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let targetAnchor: NSLayoutYAxisAnchor
            
        if isAlign {
            targetAnchor = useSafeArea ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor
        } else {
            targetAnchor = useSafeArea ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor
        }
            
        topAnchor.constraint(equalTo: targetAnchor, constant: isAlign ? inset : -inset).isActive = true
    }
    
    private func applyRightConstraint(to view: UIView, isAlign: Bool = true, inset: CGFloat = .zero, useSafeArea: Bool) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let targetAnchor: NSLayoutXAxisAnchor
            
        if isAlign {
            targetAnchor = useSafeArea ? view.safeAreaLayoutGuide.rightAnchor : view.rightAnchor
        } else {
            targetAnchor = useSafeArea ? view.safeAreaLayoutGuide.leftAnchor : view.leftAnchor
        }
            
        rightAnchor.constraint(equalTo: targetAnchor, constant: isAlign ? -inset : inset).isActive = true
    }
    
    private func applyBottomConstraint(to view: UIView, isAlign: Bool = true, inset: CGFloat = .zero, useSafeArea: Bool) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let targetAnchor: NSLayoutYAxisAnchor
            
        if isAlign {
            targetAnchor = useSafeArea ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor
        } else {
            targetAnchor = useSafeArea ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor
        }
            
        bottomAnchor.constraint(equalTo: targetAnchor, constant: isAlign ? -inset : inset).isActive = true
    }
    
    // MARK: Spacing Constraints
    
    private func applyLeftSpacingConstraint(to view: UIView, inset: CGFloat = .zero, useSafeArea: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let targetAnchor = useSafeArea ? view.safeAreaLayoutGuide.rightAnchor : view.rightAnchor
        
        leftAnchor.constraint(equalTo: targetAnchor, constant: inset).isActive = true
    }
    
    private func applyTopSpacingConstraint(to view: UIView, inset: CGFloat = .zero, useSafeArea: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let targetAnchor = useSafeArea ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor
        
        topAnchor.constraint(equalTo: targetAnchor, constant: inset).isActive = true
    }
    
    private func applyRightSpacingConstraint(to view: UIView, inset: CGFloat = .zero, useSafeArea: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let targetAnchor = useSafeArea ? view.safeAreaLayoutGuide.leftAnchor : view.leftAnchor
        
        rightAnchor.constraint(equalTo: targetAnchor, constant: -inset).isActive = true
    }
    
    private func applyBottomSpacingConstraint(to view: UIView, inset: CGFloat = .zero, useSafeArea: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let targetAnchor = useSafeArea ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor
        
        bottomAnchor.constraint(equalTo: targetAnchor, constant: -inset).isActive = true
    }
    
    // MARK: Center Constraints
    
    private func applyCenterXConstraint(to view: UIView, offset: CGFloat = .zero, useSafeArea: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let targetAnchor = useSafeArea ? view.safeAreaLayoutGuide.centerXAnchor : view.centerXAnchor
        
        centerXAnchor.constraint(equalTo: targetAnchor, constant: offset).isActive = true
    }
    
    private func applyCenterYConstraint(to view: UIView, offset: CGFloat = .zero, useSafeArea: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let targetAnchor = useSafeArea ? view.safeAreaLayoutGuide.centerYAnchor : view.centerYAnchor
        
        centerYAnchor.constraint(equalTo: targetAnchor, constant: offset).isActive = true
    }
    
    // MARK: Size Constraints
    
    private func applyEqualHeightConstraint(with view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier, constant: constant).isActive = true
    }
    
    private func applyEqualWidthConstraint(with view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier, constant: constant).isActive = true
    }
    
    private func applyHeightConstraint(size: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func applyWidthConstraint(size: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalToConstant: size).isActive = true
    }
}
