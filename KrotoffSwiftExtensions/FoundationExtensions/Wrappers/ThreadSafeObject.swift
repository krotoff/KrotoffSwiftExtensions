//
//  ThreadSafeObject.swift
//  MyFoundationExtensions
//
//  Created by Andrew Krotov on 20.02.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import Foundation

@propertyWrapper
public class ThreadSafeObject<ObjectType> {
    
    // MARK: - Public properties
    
    public var wrappedValue: ObjectType {
        get {
            var result = defaultValue
            isolationQueue.sync {
                result = value
            }
            return result
        }
        set {
            isolationQueue.async(flags: .barrier) { [weak self] in
                self?.value = newValue
            }
        }
    }
    
    // MARK: - Private properties
    
    private let isolationQueue: DispatchQueue
    private let defaultValue: ObjectType
    private var value: ObjectType
    
    // MARK: - Initialization
    
    public init(queueName: String, defaultValue: ObjectType) {
        isolationQueue = DispatchQueue(label: queueName, attributes: .concurrent)
        self.defaultValue = defaultValue
        value = defaultValue
    }
}
