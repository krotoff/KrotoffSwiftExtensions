//
//  Array.swift
//  MyFoundationExtensions
//
//  Created by Andrew Krotov on 11.04.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

public extension Array {
    
    // MARK: - Public methods
    
    mutating func move(item: Element, fromIndex: Int, toIndex: Int) {
        remove(at: fromIndex)
        insert(item, at: toIndex)
    }
}

public extension Array where Element: Identifiable {
    
    // MARK: - Public types
    
    struct Moving: Equatable, Comparable {
        
        // MARK: - Public properties
        
        public var fromIndex: Int
        public var toIndex: Int
        public var vector: Int
        public var distance: Int
        
        // MARK: - Initialization
        
        public init(fromIndex: Int, toIndex: Int) {
            self.fromIndex = fromIndex
            self.toIndex = toIndex
            
            vector = toIndex - fromIndex
            distance = abs(vector)
        }
        
        // MARK: - Public methods
        
        public static func < (lhs: Array<Element>.Moving, rhs: Array<Element>.Moving) -> Bool {
            if abs(lhs.fromIndex - lhs.toIndex) != abs(rhs.fromIndex - rhs.toIndex) {
                return abs(lhs.fromIndex - lhs.toIndex) > abs(rhs.fromIndex - rhs.toIndex)
            }
            
            if lhs.fromIndex != rhs.fromIndex {
                return lhs.fromIndex < rhs.fromIndex
            }
            
            return lhs.toIndex <= rhs.toIndex
        }
    }
    
    struct ChangedIndices: Equatable {
        
        // MARK: - Public properties
        
        public var deleted: [Int] = []
        public var inserted: [Int] = []
        public var updated: [Int] = []
        public var moved: [Moving] = []
        
        public var isEmpty: Bool { deleted.isEmpty && inserted.isEmpty && updated.isEmpty && moved.isEmpty }
        
        // MARK: - Public methods
        
        public static func == (lhs: ChangedIndices, rhs: ChangedIndices) -> Bool {
            return lhs.deleted == rhs.deleted
                && lhs.inserted == rhs.inserted
                && lhs.updated == rhs.updated
                && lhs.moved == rhs.moved
        }
    }
    
    // MARK: - Private types
    
    private typealias InfoWithIndex = (index: Int, element: Element)
    
    // MARK: - Public methods
    
    func toDictionary() -> [String: Element] {
        return reduce([String: Element]()) { (result, element) -> [String: Element] in
            var newResult = result
            newResult[element.idValue] = element
            return newResult
        }
    }
    
    func calculateChanges(with newValue: [Element]) -> ChangedIndices {
        let newObjectsIndex = newValue.toDictionaryWithIndexes()
        var oldValue = self
        
        var deleted = [Int]()
        var inserted = [Int]()
        var updated = [Int]()
        var moved = [Moving]()
        
        deleted = oldValue.indicesToInsert(in: newObjectsIndex).reversed()
        deleted.forEach { oldValue.remove(at: $0) }
        
        if !newObjectsIndex.isEmpty {
            let oldObjects = oldValue.toDictionary()
            
            inserted = newValue.indicesToInsert(in: oldObjects)
            inserted.forEach { oldValue.insert(newValue[$0], at: $0) }
            
            let oldObjectsIndex = self.toDictionaryWithIndexes()
            
            newObjectsIndex.forEach { (key, value) in
                guard let oldObjectInfo = oldObjectsIndex[key] else { return }
                
                if oldObjectInfo.index != value.index {
                    moved.append(Moving(fromIndex: oldObjectInfo.index, toIndex: value.index))
                }
                
                if oldObjectInfo.element != value.element {
                    updated.append(value.index)
                }
            }

            updated.sort()
            moved.sort()
            
            let precheckedMoves = moved
            for move in precheckedMoves {
                guard moved.contains(where: { $0 == move }) else { continue }
                
                let minPoint = Swift.min(move.fromIndex, move.toIndex)
                let maxPoint = Swift.max(move.fromIndex, move.toIndex)
                let range = minPoint...maxPoint
                let direction = move.fromIndex - move.toIndex
                
                moved.removeAll {
                    let moveDirection = $0.fromIndex - $0.toIndex
                    return range.contains($0.fromIndex)
                        && range.contains($0.toIndex)
                        && move != $0
                        && moveDirection * direction < 0
                }
            }
        }
        
        return ChangedIndices(deleted: deleted, inserted: inserted, updated: updated, moved: moved)
    }
    
    // MARK: - Private properties
    
    private func indicesToInsert(in dictionary: [String: Any]) -> [Int] {
        guard !isEmpty else { return [] }
        
        var result = [Int]()
        for index in 0..<count where dictionary[self[index].idValue] == nil {
            result.append(index)
        }
        
        return result
    }
    
    private func toDictionaryWithIndexes() -> [String: InfoWithIndex] {
        guard !isEmpty else { return [:] }
        
        var result = [String: InfoWithIndex]()
        for index in 0..<count {
            let newElement = self[index]
            result[newElement.idValue] = (index: index, element: newElement)
        }
        
        return result
    }
}
