//
//  Codable.swift
//  MyFoundationExtensions
//
//  Created by Andrew Krotov on 21.07.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import Foundation

public enum OneOfType<FirstType: Codable, SecondType: Codable>: Codable {
    
    case first(FirstType)
    case second(SecondType)
    
    // MARK: - Initialization
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(FirstType.self) {
            self = .first(x)
        } else if let x = try? container.decode(SecondType.self) {
            self = .second(x)
        } else {
            throw DecodingError.typeMismatch(OneOfType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for OneOfType"))
        }
    }
    
    // MARK: - Public methods
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .first(let x):
            try container.encode(x)
        case .second(let x):
            try container.encode(x)
        }
    }
}
