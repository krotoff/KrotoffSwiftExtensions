//
//  Predicated.swift
//  MyCoreDataExtensions
//
//  Created by Andrew Krotov on 21.07.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//


import Foundation
import CoreData

public struct Predicated<T: NSManagedObject> {
    
    // MARK: - Public properties
    
    public let entity: NSEntityDescription
    public let predicate: NSPredicate
    
    // MARK: - Initialization
    
    public init(predicate: NSPredicate) {
        self.entity = T.entity()
        self.predicate = predicate
    }
}

extension Predicated {
    public var fetchRequest: NSFetchRequest<T> {
        let request = NSFetchRequest<T>()
        request.entity = entity
        request.predicate = predicate
        
        return request
    }
}

extension Sequence where Iterator.Element: NSManagedObject {
    public func filter(with predicate: NSPredicate) -> [Iterator.Element] {
        let predicated = Predicated<Iterator.Element>(predicate: predicate)
        return filter(with: predicated)
    }
    
    public func filter(with predicated: Predicated<Iterator.Element>) -> [Iterator.Element] {
        return filter { object in
            guard object.entity == predicated.entity else { return false }
            
            return predicated.predicate.evaluate(with: object)
        }
    }
    
    public func filterAndCast<T: NSManagedObject>(with predicated: Predicated<T>) -> [T] {
        return compactMap { mo in
            guard let casted = mo as? T, predicated.predicate.evaluate(with: casted) else { return nil }
            
            return casted
        }
    }
}
