//
//  NibView.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 15.02.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

open class NibView: UIView {
    
    // MARK: - Open properties
    
    open class var nibName: String { String(describing: self) }
    open class var nibBundle: Bundle { Bundle(for: self) }
    
    // MARK: - Public properties
    
    public private(set) var contentView: UIView!
    
    // MARK: - Initialization
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    // MARK: - Private methods
    
    private func initialize() {
        backgroundColor = .clear
        contentView = loadNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    private func loadNib() -> UIView {
        let bundle = type(of: self).nibBundle
        let nibName = type(of: self).nibName
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
}
