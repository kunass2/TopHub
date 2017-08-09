//
//  UITableViewTests.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import XCTest
@testable import TopHub

class UITableViewTests: XCTestCase {
    
    func testIsLastForIndexPathWithOneRowReturnsTrue() {
        XCTAssertTrue(TableViewStub(numberOfRows: 1).tableView.isLast(for: IndexPath(row: 0, section: 0)))
    }
    
    func testIsLastForIndexPathWithOneRowReturnsFalse() {
        XCTAssertFalse(TableViewStub(numberOfRows: 1).tableView.isLast(for: IndexPath(row: 1, section: 0)))
    }
    
    func testIsLastForIndexPathWithThreeRowsReturnsFalse() {
        XCTAssertFalse(TableViewStub(numberOfRows: 3).tableView.isLast(for: IndexPath(row: 1, section: 0)))
    }
    
    func testIsLastForIndexPathWithThreeRowsReturnsTrue() {
        XCTAssertTrue(TableViewStub(numberOfRows: 3).tableView.isLast(for: IndexPath(row: 2, section: 0)))
    }
}

private class TableViewStub: NSObject, UITableViewDataSource {
    
    private var numberOfRows = 0
    
    var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    init(numberOfRows: Int = 1) {
        
        self.numberOfRows = numberOfRows
        
        super.init()
        
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
