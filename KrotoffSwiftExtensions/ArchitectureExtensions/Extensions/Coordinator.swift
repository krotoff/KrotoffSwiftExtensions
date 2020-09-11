//
//  Coordinator.swift
//  MyArchitectureExtensions
//
//  Created by Andrew Krotov on 02.12.2019.
//  Copyright © 2019 Andrew Krotov. All rights reserved.
//

import Foundation

public protocol CoordinatorType {
    var identifier: UUID { get }
    
    func startAndStore(in: CoordinatorType, animated: Bool)
    func store(coordinator: CoordinatorType)
    func start(animated: Bool)
    func stop(animated: Bool)
    func stop(animated: Bool, completion: (() -> Void)?)
}

open class Coordinator: CoordinatorType {
    
    // MARK: - Public properties
        
    public var onCompleted: (() -> Void)!
    public let identifier = UUID()
    
    // MARK: - Private properties
    
    private var childCoordinators = [UUID: CoordinatorType]()
    
    // MARK: - Initialization
    
    public init() {}
    
    // MARK: - CoordinatorType methods
    
    open func start(animated: Bool = true) {
        fatalError("#ERR: Method start(animated:) for \(Self.self) should be implemented")
    }
    
    open func stop(animated: Bool = true) {
        stop(animated: animated, completion: nil)
    }
    
    open func stop(animated: Bool = true, completion: (() -> Void)?) {}
    
    // MARK: - Open methods
    
    @discardableResult
    open func configureCallbacks(onCompleted: @escaping (() -> Void)) -> Coordinator {
        self.onCompleted = onCompleted
        
        return self
    }
    
    // MARK: - Public methods
    
    public func startAndStore(in coordinator: CoordinatorType, animated: Bool = true) {
        start(animated: animated)
        coordinator.store(coordinator: self)
    }
    
    // MARK: Parent Coodinator methods
    
    public func store(coordinator: CoordinatorType) {
        childCoordinators[coordinator.identifier] = coordinator
    }
    
    public func free(_ coordinator: CoordinatorType, animated: Bool = true, completion: (() -> Void)? = nil) {
        coordinator.stop(animated: animated, completion: completion)
        childCoordinators.removeValue(forKey: coordinator.identifier)
    }
    
    public func freeAllChildren(animated: Bool = true) {
        childCoordinators.values.forEach { [weak self] coordinator in
            self?.free(coordinator, animated: animated)
        }
    }
}

open class RoutableCoordinator<Route>: Coordinator {
    
    // MARK: - Public properties
    
    public var openRoute: ((Route) -> Void)?
    
    // MARK: - Open methods
    
    @discardableResult
    open func configureCallbacks(openRoute: @escaping ((Route) -> Void), onCompleted: @escaping (() -> Void)) -> Coordinator {
        self.openRoute = openRoute
        
        return super.configureCallbacks(onCompleted: onCompleted)
    }
}
