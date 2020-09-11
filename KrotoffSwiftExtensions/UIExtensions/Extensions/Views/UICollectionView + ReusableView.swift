//
//  UICollectionView.swift
//  MyUIExtensions
//
//  Created by Andrew Krotov on 28.04.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import UIKit

public protocol CollectionSectionType: Equatable {
    associatedtype ItemType: Identifiable
    
    var items: [ItemType] { get }
}

public extension UICollectionView {
    
    // MARK: - Public types
    
    typealias MainProtocols = UICollectionViewDelegate & UICollectionViewDataSource
    typealias DnDProtocols = UICollectionViewDragDelegate & UICollectionViewDropDelegate
    
    // MARK: - Public properties
    
    var availableWidth: CGFloat { bounds.width - (contentInset.left + contentInset.right) }
    var availableHeight: CGFloat { bounds.height - (contentInset.top + contentInset.bottom) }
    
    // MARK: - Initialization
    
    convenience init(
        layout: UICollectionViewLayout,
        cellClasses: [UICollectionViewCell.Type],
        refreshControl: UIRefreshControl? = nil,
        contentInset: UIEdgeInsets = .zero,
        delaysContentTouches: Bool = false,
        backgroundColor: UIColor = .clear
    ) {
        self.init(frame: .zero, collectionViewLayout: layout)
        
        register(cellClasses)
        self.refreshControl = refreshControl
        self.contentInset = contentInset
        self.delaysContentTouches = delaysContentTouches
        self.backgroundColor = backgroundColor
    }
    
    // MARK: - Public methods
    
    // MARK: Setting up
    
    func setup(in parent: MainProtocols) {
        delegate = parent
        dataSource = parent
    }
    
    func setupDraggable(in parent: MainProtocols & DnDProtocols) {
        setup(in: parent)
        
        dragDelegate = parent
        dropDelegate = parent
        dragInteractionEnabled = true
    }
    
    // MARK: Registering
    
    func register(_ cellClasses: [UICollectionViewCell.Type]) {
        cellClasses.forEach(register)
    }
    
    func register(_ cellClass: UICollectionViewCell.Type) {
        if Bundle(for: cellClass.self).path(forResource: String(describing: cellClass.self), ofType: "nib") != nil {
            register(
                UINib(nibName: cellClass.reuseIdentifier, bundle: cellClass.bundle),
                forCellWithReuseIdentifier: cellClass.reuseIdentifier
            )
        } else {
            register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        }
    }
    
    func registerSupplementary(_ viewClass: UICollectionReusableView.Type, of kind: String) {
        if Bundle(for: viewClass.self).path(forResource: String(describing: viewClass.self), ofType: "nib") != nil {
            register(
                UINib(nibName: viewClass.reuseIdentifier, bundle: viewClass.bundle),
                forSupplementaryViewOfKind: kind,
                withReuseIdentifier: viewClass.reuseIdentifier
            )
        } else {
            register(viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: viewClass.reuseIdentifier)
        }
    }
    
    // MARK: Dequeuing

    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueSupplementaryView<T: UICollectionReusableView>(for indexPath: IndexPath, of kind: String) -> T {
        dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    // MARK: Updating
    
    func update<T: CollectionSectionType>(from oldObjects: [T], to newObjects: [T], completion: ((Bool) -> Void)? = nil) {
        if oldObjects.count == 0 || newObjects.count == 0 {
            DispatchQueue.main.async { [weak self] in
                self?.reloadData()
                completion?(true)
            }
        } else {
            var completionsCounter = 0
            var hasChanges = false
            for sectionIndex in 0..<max(oldObjects.count, newObjects.count) {
                let oldItems = oldObjects.indices.contains(sectionIndex) ? oldObjects[sectionIndex].items : []
                let newItems = newObjects.indices.contains(sectionIndex) ? newObjects[sectionIndex].items : []
                updateSection(withIndex: sectionIndex, from: oldItems, to: newItems) { hasChangesInSection in
                    completionsCounter += 1
                    if hasChangesInSection {
                        hasChanges = hasChangesInSection
                    }
                    if completionsCounter == newObjects.count {
                        DispatchQueue.main.async {
                            completion?(hasChanges)
                        }
                    }
                }
            }
        }
    }
    
    func updateSection<T: Identifiable>(
        withIndex index: Int,
        from oldObjects: [T],
        to newObjects: [T],
        completion: ((Bool) -> Void)? = nil
    ) {
        if oldObjects.count == 0 || newObjects.count == 0 {
            reloadSections([index])
            completion?(true)
        } else {
            let changes = oldObjects.calculateChanges(with: newObjects)
            
            guard !changes.isEmpty else {
                completion?(false)
                return
            }
            
            performBatchUpdates({
                deleteItems(at: changes.deleted.map { IndexPath(item: $0, section: index) })
                insertItems(at: changes.inserted.map { IndexPath(item: $0, section: index) })
                changes.moved.forEach {
                    moveItem(at: IndexPath(item: $0.fromIndex, section: index), to: IndexPath(item: $0.toIndex, section: index))
                }
            }, completion: { [weak self] _ in
                self?.performBatchUpdates({
                    self?.reloadItems(at: changes.updated.map { IndexPath(item: $0, section: index) })
                }, completion: { _ in
                    completion?(true)
                })
            })
        }
    }
    
    // MARK: Delegates Handling
    
    func defaultDropSessionDidUpdateHandling(session: UIDropSession) -> UICollectionViewDropProposal {
        guard session.items.count == 1 else { return UICollectionViewDropProposal(operation: .cancel) }
        
        let operation: UIDropOperation = hasActiveDrag ? .move : .copy
        
        return UICollectionViewDropProposal(operation: operation, intent: .insertAtDestinationIndexPath)
    }
}

public extension UICollectionViewFlowLayout {
    
    // MARK: - Initialization
    
    convenience init(scrollDirection: UICollectionView.ScrollDirection, minimumLineSpacing: CGFloat, minimumInteritemSpacing: CGFloat) {
        self.init()
        
        self.scrollDirection = scrollDirection
        self.minimumLineSpacing = minimumLineSpacing
        self.minimumInteritemSpacing = minimumInteritemSpacing
    }
}

public extension UICollectionReusableView {
    
    // MARK: - Public properties

    static var reuseIdentifier: String { return String(describing: self) }
    static var bundle: Bundle { return Bundle(for: Self.self) }
    
    // MARK: - Public methods
    
    func gestureRecognizerShouldBeginForSwipableCell(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let recognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let velocity = recognizer.velocity(in: self)
            return abs(velocity.y) < abs(velocity.x)
        }

        return true
    }
}
