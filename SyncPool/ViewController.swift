//
//  ViewController.swift
//  SyncPool
//
//  Created by Dylan Lewis on 31/10/2016.
//  Copyright © 2016 Dylan Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var initialDemoItems = [DemoItem]()
    var updatedDemoItems = [DemoItem]()
    
    var syncPool: SyncPool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupDemoItems()
        self.setupSyncPool()
        //self.addItems(items: initialDemoItems)
        //self.addItems(items: updatedDemoItems)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupSyncPool() {
        let parser = DemoItemParser()
        self.syncPool = SyncPool(parsers: [parser])
    }
    
    func setupDemoItems() {
        let numberOfItems = 100000
        
        let initialItemsStartTime = Date()
        for index in 0..<numberOfItems {
            let initialDemoItem = DemoItem(name: "initial\(index)", age: index, identifier: "\(index)")
            initialDemoItems.append(initialDemoItem)
        }
        let initialItemsEndTime = Date()
        let timeDifference = initialItemsEndTime.timeIntervalSince(initialItemsStartTime)
        print("Array creation time: \(timeDifference)")
        
        for index in 0..<numberOfItems {
            let updatedDemoItem = DemoItem(name: "updated\(index)", age: index*index, identifier: "\(index)")
            updatedDemoItems.append(updatedDemoItem)
        }
    }
    
    func addItems(items: [DemoItem]) {
        syncPool.append(items: items, withCompletion: nil)
    }
}

