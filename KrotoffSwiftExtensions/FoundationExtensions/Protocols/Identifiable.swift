//
//  Identifiable.swift
//  MyFoundationExtensions
//
//  Created by Andrew Krotov on 13.04.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

public protocol Identifiable: Equatable {
    var idValue: String { get }
}
