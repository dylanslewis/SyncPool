//
//  SyncPoolTests.swift
//  SyncPoolTests
//
//  Created by Dylan Lewis on 31/10/2016.
//  Copyright © 2016 Dylan Lewis. All rights reserved.
//

import XCTest
@testable import SyncPool

class SyncPoolTests: XCTestCase {
    
    var syncPool: SyncPool!
    
    override func setUp() {
        super.setUp()

        let demoItemParser = DemoItemParser()
        self.syncPool = SyncPool(parsers: [demoItemParser])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddingItemToSyncPoolAddsItemToPool() {
        
    }
    
    func testUpdatingItemInSyncPoolUpdatesItem() {
        
    }
    
    func testAddingItemToSyncPoolWithNoParserFails() {
        
    }
    
    func testCreatingSyncPoolWithParsersWithTheSameTypeFails() {
        
    }
    
    func testAddingItemToSyncPoolWithMultipleParsersAddsTheItemToTheCorrectPool() {
        
    }
    
    func testResetingSyncPoolRemovesAllitems() {
        
    }
}
