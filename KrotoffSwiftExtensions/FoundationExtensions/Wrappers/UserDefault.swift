//
//  UserDefault.swift
//  MyFoundationExtensions
//
//  Created by Andrew Krotov on 20.02.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserDefault<ObjectType: Codable> {
    
    // MARK: - Public properties
    
    public var wrappedValue: ObjectType {
        get {
            let object = UserDefaults.standard.object(forKey: key)
            
            if let value = object as? ObjectType { return value }
            
            if let data = object as? Data {
                do {
                    let value = try JSONDecoder().decode(ObjectType.self, from: data)
                    return value
                } catch {
                    print("#ERR Could not decode \(ObjectType.self)", error)
                }
            }
            
            return defaultValue
        }
        set {
            if newValue is Bool || newValue is Double || newValue is Float || newValue is Int || newValue is String {
                UserDefaults.standard.set(newValue, forKey: key)
            } else {
                do {
                    UserDefaults.standard.set(try JSONEncoder().encode(newValue), forKey: key)
                } catch {
                    print("#ERR Could not encode \(ObjectType.self)", error)
                }
            }
        }
    }
    
    // MARK: - Private properties
    
    private let key: String
    private let defaultValue: ObjectType
    
    // MARK: - Initialization
    
    public init(key: String, defaultValue: ObjectType) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

