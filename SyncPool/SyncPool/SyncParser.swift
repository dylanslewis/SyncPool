//
//  SyncParser.swift
//  SyncPool
//
//  Created by Dylan Lewis on 31/10/2016.
//  Copyright © 2016 Dylan Lewis. All rights reserved.
//

import Foundation

protocol SyncParser {
    var type: String { get }
    var estimatedCapacity: Int? { get }
    
    func combine<A: Identifiable>(oldItem: A, with newItem: A) -> A?
}
