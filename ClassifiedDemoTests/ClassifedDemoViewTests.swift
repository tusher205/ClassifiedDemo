//
//  ClassifedDemoViewTests.swift
//  ClassifiedDemoTests
//
//  Created by Takvir Hossain Tusher on 22/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import XCTest
@testable import ClassifiedDemo

class ClassifedDemoViewTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testClassifedListView() {
        let viewNib = ProductListTableViewCell.loadNib()
        XCTAssertNotNil(viewNib)
        
        let viewReuseId = ProductListTableViewCell.reuseIdentifier()
        XCTAssertNotNil(viewReuseId)
        
        let classifiedVC = ProductListViewController()
        XCTAssertNotNil(classifiedVC)
        
        let detailVC = ProductDetailViewController()
        XCTAssertNotNil(detailVC)
    }
}

