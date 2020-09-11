//
//  UserDefaults+Array.swift
//  MyFoundationExtensions
//
//  Created by Andrew Krotov on 08.12.2019.
//  Copyright © 2019 Andrew Krotov. All rights reserved.
//

import Foundation

public extension UserDefaults {
    
    // MARK: - Public methods
    
    func set<T: Encodable>(_ array: [T]?, for key: String) {
        do {
            set(try JSONEncoder().encode(array), forKey: key)
        } catch {
            print("#ERR Could not encode", String(describing: T.self), error)
        }
    }
    
    func array<T: Decodable>(for key: String) -> [T]? {
        if let data = value(forKey: key) as? Data {
            do {
                return try JSONDecoder().decode([FailableDecodable<T>].self, from: data)
                    .compactMap { $0.base }
            } catch {
                print("#ERR Could not decode", String(describing: T.self), error)
            }
        }
        
        return nil
    }
    
    func updateOrCreateItemInArray<T: Codable & Equatable>(_ item: T, arrayKey: String) {
        let storagedArray: [T]? = array(for: arrayKey)
        
        if let array = storagedArray, !array.isEmpty {
            if array.contains(item) {
                set(array.map { $0 == item ? item : $0 }, for: arrayKey)
            } else {
                set([item] + array, for: arrayKey)
            }
        } else {
            set([item], for: arrayKey)
        }
    }
    
    func removeItemFromArray<T: Codable & Equatable>(_ item: T, arrayKey: String) {
        guard let storagedArray = array(for: arrayKey) as [T]? else { return }
        
        set(storagedArray.filter { $0 != item }, for: arrayKey)
    }
}
