//
//  DemoItemParser.swift
//  SyncPool
//
//  Created by Dylan Lewis on 31/10/2016.
//  Copyright © 2016 Dylan Lewis. All rights reserved.
//

import Foundation

class DemoItemParser: SyncParser {
    var type: String = "DemoItem"
    var estimatedCapacity: Int?
    
    
    // MARK: Initializer
    convenience init(estimatedCapacity: Int? = nil) {
        self.init()
        self.estimatedCapacity = estimatedCapacity
    }

    
    // MARK: SyncParser
    func combine<A : Identifiable>(oldItem: A, with newItem: A) -> A? {
        // Check that the type is correct.
        guard let oldDemoItem = oldItem as? DemoItem, let newDemoItem = newItem as? DemoItem else {
            return nil
        }
        
        let name = newDemoItem.name ?? oldDemoItem.name
        let age = newDemoItem.age ?? oldDemoItem.age
        
        return DemoItem(name: name, age: age, identifier: oldDemoItem.identifier) as? A
    }
}
