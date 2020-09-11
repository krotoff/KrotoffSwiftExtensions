//
//  NSManagedObject.swift
//  MyCoreDataExtensions
//
//  Created by Andrew Krotov on 21.07.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import Foundation
import CoreData

public protocol Managed: NSManagedObject {}

extension NSManagedObject: Managed {}

public extension Managed {
    
    // MARK: - Public properties
    
    static var entity: NSEntityDescription { entity() }
    static var entityName: String { entity.name! }
    
    // MARK: - Public methods
    
    static func findOneOrCreate(
        in context: NSManagedObjectContext,
        matching predicate: NSPredicate,
        configure: (Self) throws -> Void,
        configureFetchRequest: (NSFetchRequest<Self>) -> Void = { _ in }
    ) throws -> Self {
        if let object = try findOneOrFetch(in: context, matching: predicate, configureFetchRequest: configureFetchRequest) {
            return object
        } else {
            let newObject: Self = context.insertObject()
            try configure(newObject)
            return newObject
        }
    }
    
    static func findOneOrFetch(
        in context: NSManagedObjectContext,
        matching predicate: NSPredicate,
        configureFetchRequest: (NSFetchRequest<Self>) -> Void = { _ in }
    ) throws -> Self? {
        if let object = materializeObject(in: context, matching: predicate) {
            return object
        } else {
            return try fetch(in: context) { request in
                request.predicate = predicate
                request.returnsObjectsAsFaults = false
                request.fetchLimit = 1
                configureFetchRequest(request)
            }.first
        }
    }
    
    static func fetch(in context: NSManagedObjectContext, configure: (NSFetchRequest<Self>) -> Void = { _ in }) throws -> [Self] {
        let request = NSFetchRequest<Self>(entityName: entityName)
        configure(request)
        
        return try context.fetch(request)
    }
    
    static func count(in context: NSManagedObjectContext, configure: (NSFetchRequest<Self>) -> Void = { _ in }) throws -> Int {
        let request = NSFetchRequest<Self>(entityName: entityName)
        configure(request)
        
        return try context.count(for: request)
    }
    
    static func materializeObject(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> Self? {
        for object in context.registeredObjects where !object.isFault {
            if let result = object as? Self, predicate.evaluate(with: result) {
                return result
            }
        }
        
        return nil
    }
    
    static func materializeObjects(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> [Self] {
        let predicated = Predicated<Self>(predicate: predicate)
        
        return context.registeredObjects.filterAndCast(with: predicated)
    }
    
    static func makeFetchRequest() -> NSFetchRequest<Self> { NSFetchRequest<Self>(entityName: entityName) }
}
