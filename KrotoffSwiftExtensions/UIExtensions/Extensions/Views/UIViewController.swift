//
//  UIViewController.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 12.02.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    // MARK: - Public methods
    
    func showShareController(with text: String) {
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        presentViewControllerWithPopoverPossibility(activityViewController)
    }
    
    func presentAlertController(
        title: String? = nil,
        message: String? = nil,
        preferredStyle: UIAlertController.Style = .alert,
        defaultActions: [UIAlertAction] = [],
        cancelTitle: String? = "OK"
    ) {
        let requiredStyle = UIDevice.current.userInterfaceIdiom == .pad ? .actionSheet : preferredStyle
        let alertController = UIAlertController(title: title, message: message, preferredStyle: requiredStyle)
        
        defaultActions.forEach(alertController.addAction)
        cancelTitle.map { alertController.addAction(UIAlertAction(title: $0, style: .cancel, handler: nil)) }
        
        presentViewControllerWithPopoverPossibility(alertController)
    }
    
    func dismissWithPopAnimation() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromLeft
        view.window!.layer.add(transition, forKey: kCATransition)

        dismiss(animated: false)
    }
    
    func addTapGestureToEndEditing() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized))
        tapGesture.cancelsTouchesInView = false
        view.gestureRecognizers?.forEach(view.removeGestureRecognizer)
        [tapGesture].forEach(view.addGestureRecognizer)
    }
    
    func close(animated: Bool = true, completion: (() -> Void)? = nil) {
        if let navigationController = navigationController, navigationController.viewControllers.contains(self) {
            navigationController.popViewController(animated: animated)
            completion?()
        } else if navigationController == nil {
            dismiss(animated: animated, completion: completion)
        }
    }
    
    // MARK: - Private methods
    
    private func presentViewControllerWithPopoverPossibility(_ viewController: UIViewController) {
        if let popoverPresentationController = viewController.popoverPresentationController {
            popoverPresentationController.sourceView = view
            let centerPoint = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.sourceRect = centerPoint
            popoverPresentationController.permittedArrowDirections = []
        }
        present(viewController, animated: true)
    }
    
    @objc private func tapGestureRecognized() {
        view.endEditing(true)
    }
}
