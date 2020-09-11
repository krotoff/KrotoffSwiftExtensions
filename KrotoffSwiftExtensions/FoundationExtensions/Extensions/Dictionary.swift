//
//  Dictionary.swift
//  MyFoundationExtensions
//
//  Created by Andrew Krotov on 15.07.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    // MARK: - Public properties
    
    var queryString: String { map { (key, value) in "\(key)=\(value)" }.joined(separator: "&") }
}
