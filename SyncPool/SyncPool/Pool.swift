//
//  Pool.swift
//  SyncPool
//
//  Created by Dylan Lewis on 31/10/2016.
//  Copyright © 2016 Dylan Lewis. All rights reserved.
//

import Foundation

class Pool {
    var count: Int {
        return itemForIdentifier.count
    }
    
    var allItems: [Identifiable] {
        return Array(itemForIdentifier.values)
    }
    
    private var itemForIdentifier = [String: Identifiable]()
    
    
    // MARK: Initializer
    convenience init(estimatedCapacity: Int? = nil) {
        self.init()
        self.itemForIdentifier = Dictionary<String, Identifiable>(minimumCapacity: estimatedCapacity ?? 0)
    }
    
    func append<A: Identifiable>(item: A) {
        itemForIdentifier[item.identifier] = item
    }
    
    func contains<A: Identifiable>(item: A) -> Bool {
        return self.item(for: item.identifier) != nil
    }
    
    func item(for identifier: String) -> Identifiable? {
        return itemForIdentifier[identifier]
    }
}
