//
//  PoolTests.swift
//  SyncPool
//
//  Created by Dylan Lewis on 31/10/2016.
//  Copyright © 2016 Dylan Lewis. All rights reserved.
//

import XCTest
@testable import SyncPool

class PoolTests: XCTestCase {
    
    var pool: Pool!
    
    override func setUp() {
        super.setUp()
        
        self.pool = Pool()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddingItemToPoolAddsItemToPool() {
        let item = DemoItem(name: "name", age: 0, identifier: "identifier")
        pool.append(item: item)
        
        XCTAssertEqual(pool.count, 1)
        XCTAssertEqual(pool.item(for: "identifier") as! DemoItem, item)
    }
    
    func testAddingItemsWithDifferentIdentifiersAddsUniqueUtemsToThePool() {
        let itemOne = DemoItem(name: "name", age: 0, identifier: "identifierOne")
        pool.append(item: itemOne)

        let itemTwo = DemoItem(name: "name", age: 0, identifier: "identifierTwo")
        pool.append(item: itemTwo)

        XCTAssertEqual(pool.count, 2)
    }

    func testUpdatingItemUpdatesOriginalItem() {
        let item = DemoItem(name: "name", age: 0, identifier: "identifier")
        pool.append(item: item)
        
        XCTAssertEqual(pool.count, 1)
        
        let updatedItem = DemoItem(name: "new name", age: 1, identifier: "identifier")
        pool.append(item: updatedItem)

        let updatedItemFromPool = pool.item(for: "identifier") as! DemoItem
        XCTAssertEqual(updatedItemFromPool, updatedItem)
        XCTAssertEqual(updatedItemFromPool.name, updatedItem.name)
        XCTAssertEqual(updatedItemFromPool.age, updatedItem.age)
        XCTAssertEqual(updatedItemFromPool.identifier, updatedItem.identifier)
    }
    
    func testUpdatingItemDoesNotIncreasePoolCount() {
        let item = DemoItem(name: "name", age: 0, identifier: "identifier")
        pool.append(item: item)
        
        XCTAssertEqual(pool.count, 1)

        let updatedItem = DemoItem(name: "new name", age: 1, identifier: "identifier")
        pool.append(item: updatedItem)
        
        XCTAssertEqual(pool.count, 1)
    }
}
