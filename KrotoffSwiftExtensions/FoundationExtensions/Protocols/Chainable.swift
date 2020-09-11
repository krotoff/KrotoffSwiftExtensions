//
//  Chainable.swift
//  MyFoundationExtensions
//
//  Created by Andrew Krotov on 21.07.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import Foundation

public protocol Chainable: NSObject {}

public extension Chainable {
    @discardableResult
    func set<ValueType>(_ key: KeyPath<Self, ValueType>, value: ValueType) -> Self {
        setValue(value, forKeyPath: key.toString)
        
        return self
    }
}

extension NSObject: Chainable {}

extension KeyPath where Root: NSObject {
    var toString: String { NSExpression(forKeyPath: self).keyPath }
}
