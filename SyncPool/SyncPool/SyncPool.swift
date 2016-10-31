//
//  SyncPool.swift
//  SyncPool
//
//  Created by Dylan Lewis on 31/10/2016.
//  Copyright © 2016 Dylan Lewis. All rights reserved.
//

import Foundation

class SyncPool {
    var parsers: [SyncParser]!
    
    private var parserForType = [String: SyncParser]()
    private var poolForType = [String: Pool]()
    
    
    // MARK: - Initializer
    convenience init(parsers: [SyncParser]) {
        self.init()
        self.parsers = parsers
        self.reset()
    }
    
    
    // MARK: Public
    func append<A: Identifiable>(item: A, withCompletion completion: (() -> Void)?) {
        self.append(items: [item], withCompletion: completion)
    }
    
    func append<A: Identifiable>(items: [A], withCompletion completion: (() -> Void)?) {
        // Get the first item, so we can find the type.
        guard let firstItem = items.first else {
            completion?()
            return
        }
        
        // Find the parser and pool for the items' type.
        guard let parser = parser(for: firstItem), let pool = pool(for: firstItem) else {
            print("Unable to find parser and pool for \(A.self)")
            completion?()
            return
        }
        
        // Iterate over the items to add to the pool.
        for item in items {
            // Check if the item already exists in the pool.
            guard let matchedItem = synced(item: item, in: pool) else {
                // Item is new, add it to the pool.
                pool.append(item: item)
                continue
            }

            // Item exists in pool, combine their values.
            guard let combinedItem = parser.combine(oldItem: matchedItem, with: item) else {
                print("Unable to combine items with identifier: \(item.identifier)")
                continue
            }
            
            // Add the combined item to the pool.
            pool.append(item: combinedItem)
        }
        
        completion?()
    }
    
    func synced<A: Identifiable>(item: A) -> A? {
        return synced(items: [item])?.first
    }
    
    func synced<A: Identifiable>(items: [A]) -> [A]? {
        // Get the first item, so we can find the type.
        guard let firstItem = items.first else {
            return nil
        }
        
        // Find the pool for the items' type.
        guard let pool = pool(for: firstItem) else {
            return nil
        }
        
        // Create an array of the synchronized items.
        var syncedItems = [A]()
        for item in items {
            if let syncedItem = pool.item(for: item.identifier) as? A {
                syncedItems.append(syncedItem)
            }
        }
        
        return syncedItems
    }
    
    func allSyncedItems<A: Identifiable>(with type: String) -> [A]? {
        guard let pool = poolForType[type] else {
            return nil
        }
        
        return pool.allItems as? [A]
    }
    
    func reset() {
        var parserForType = [String: SyncParser]()
        var poolForType = [String: Pool]()
        
        var addedTypes = [String]()
        for parser in parsers {
            let type = parser.type
            
            // Verify the parsers are unique.
            assert(!addedTypes.contains(type), "SyncPool already contains parser with type \(type)")
            addedTypes.append(type)

            parserForType[type] = parser
            poolForType[type] = Pool(estimatedCapacity: parser.estimatedCapacity)
        }
        
        self.parserForType = parserForType
        self.poolForType = poolForType
    }
    
    
    // MARK: - Utility
    private func parser<A: Identifiable>(for item: A) -> SyncParser? {
        let type = "\(A.self)"
        return parserForType[type]
    }
    
    private func pool<A: Identifiable>(for item: A) -> Pool? {
        let type = "\(A.self)"
        return poolForType[type]
    }
    
    private func synced<A: Identifiable>(item: A, in pool: Pool) -> A? {
        return pool.item(for: item.identifier) as? A
    }
}
