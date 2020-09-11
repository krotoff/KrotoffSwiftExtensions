//
//  NSManagedObjectContext.swift
//  MyCoreDataExtensions
//
//  Created by Andrew Krotov on 02.02.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import CoreData

public extension NSManagedObjectContext {
    
    // MARK: - Public methods
    
    func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }
    
    func insertObject<T: Managed>() -> T { NSEntityDescription.insertNewObject(forEntityName: T.entityName, into: self) as! T }
}
