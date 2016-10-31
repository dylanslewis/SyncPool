//
//  DemoItem.swift
//  SyncPool
//
//  Created by Dylan Lewis on 31/10/2016.
//  Copyright © 2016 Dylan Lewis. All rights reserved.
//

import Foundation

struct DemoItem: Identifiable, Equatable, Hashable {
    var name: String?
    var age: Int?
    var identifier: String
    
    var hashValue: Int {
        return "\(name)\(age)\(identifier)".hashValue
    }
}

func ==(lhs: DemoItem, rhs: DemoItem) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
