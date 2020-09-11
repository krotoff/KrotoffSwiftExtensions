//
//  CoordinatableViewController.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 03.02.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

open class CoordinatableViewController: UIViewController {
    
    // MARK: - Public properties
    
    public var onCompleted: (() -> Void)?
    
    // MARK: - View lifecycle
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if
            let navController = navigationController,
            !navController.viewControllers.contains(self) || (navController.parent == nil && navController.presentedViewController == nil)
        {
            onCompleted?()
        } else if navigationController == nil {
            onCompleted?()
        }
    }
}
