//
//  Decodable.swift
//  MyFoundationExtensions
//
//  Created by Andrew Krotov on 31.01.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import Foundation

public struct FailableDecodable<Base: Decodable>: Decodable {

    // MARK: - Public properties
    
    public let base: Base?
    
    // MARK: - Initialization

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        do {
            base = try container.decode(Base.self)
        } catch {
            base = nil
            print("#ERR Could not decode \(Base.self):", error)
        }
    }
}
