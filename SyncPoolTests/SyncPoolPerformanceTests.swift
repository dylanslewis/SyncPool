//
//  SyncPoolPerformanceTests.swift
//  SyncPool
//
//  Created by Dylan Lewis on 31/10/2016.
//  Copyright © 2016 Dylan Lewis. All rights reserved.
//

import Foundation
import XCTest
@testable import SyncPool

class SyncPoolPerformanceTests: XCTestCase {
    
    var syncPool: SyncPool!
    
    func testPerformanceForAddingTenThousendNewItemsWithEstimatedCapacity() {
        let numberOfItems = 10000
        self.setupWithEstimatedCapacity(capacity: numberOfItems)
        
        var items = [DemoItem]()
        for index in 0..<numberOfItems {
            let initialDemoItem = DemoItem(name: "initial\(index)", age: index, identifier: "\(index)")
            items.append(initialDemoItem)
        }
        
        self.measure {
            self.syncPool.append(items: items, withCompletion: nil)
        }
    }
    
    func testPerformanceForAddingTenThousendNewItemsWithoutEstimatedCapacity() {
        let numberOfItems = 10000
        self.setupWithoutEstimatedCapacity()
        
        var items = [DemoItem]()
        for index in 0..<numberOfItems {
            let initialDemoItem = DemoItem(name: "initial\(index)", age: index, identifier: "\(index)")
            items.append(initialDemoItem)
        }
        
        self.measure {
            self.syncPool.append(items: items, withCompletion: nil)
        }
    }
    
    func testPerformanceForAddingOneHundredThousendNewItemsWithEstimatedCapacity() {
        let numberOfItems = 100000
        self.setupWithEstimatedCapacity(capacity: numberOfItems)
        
        var items = [DemoItem]()
        for index in 0..<numberOfItems {
            let initialDemoItem = DemoItem(name: "initial\(index)", age: index, identifier: "\(index)")
            items.append(initialDemoItem)
        }
        
        self.measure {
            self.syncPool.append(items: items, withCompletion: nil)
        }
    }
    
    func testPerformanceForAddingOneHundredThousendNewItemsWithoutEstimatedCapacity() {
        let numberOfItems = 100000
        self.setupWithoutEstimatedCapacity()
        
        var items = [DemoItem]()
        for index in 0..<numberOfItems {
            let initialDemoItem = DemoItem(name: "initial\(index)", age: index, identifier: "\(index)")
            items.append(initialDemoItem)
        }
        
        self.measure {
            self.syncPool.append(items: items, withCompletion: nil)
        }
    }
    
    func testPerformanceForUpdatingFiveThousendItemsInAPoolOfTenThousendItems() {
        let numberOfItems = 10000
        self.setupWithoutEstimatedCapacity()
        
        var items = [DemoItem]()
        for index in 0..<numberOfItems {
            let initialDemoItem = DemoItem(name: "initial\(index)", age: index, identifier: "\(index)")
            items.append(initialDemoItem)
        }
        
        var updatedItems = [DemoItem]()
        for index in 0..<5000 {
            let updatedDemoItem = DemoItem(name: "updated\(index)", age: index, identifier: "\(index)")
            updatedItems.append(updatedDemoItem)
        }
        
        //let initialExpectation = self.expectation(description: "Add 10000 items to SyncPool")
        let updatedExpectation = self.expectation(description: "Update 5000 items in SyncPool")
        
        self.syncPool.append(items: items, withCompletion: nil)
        
        self.syncPool.append(items: items) {
          //  initialExpectation.fulfill()
            self.measure {
                self.syncPool.append(items: updatedItems, withCompletion: nil)
                updatedExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5) { (error) in
            if let _ = error {
                XCTFail(error!.localizedDescription)
            }
        }
    }
    
    func testPerformanceForUpdatingFiftyThousendItemsInAPoolOfOneHundredThousendItems() {
        
    }
    
    
    // MARK: Utility
    func setupWithEstimatedCapacity(capacity: Int) {
        let demoItemParser = DemoItemParser(estimatedCapacity: capacity)
        self.syncPool = SyncPool(parsers: [demoItemParser])
    }
    
    func setupWithoutEstimatedCapacity() {
        let demoItemParser = DemoItemParser()
        self.syncPool = SyncPool(parsers: [demoItemParser])
    }
}
