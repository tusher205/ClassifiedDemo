//
//  ClassifiedListViewControllerTest.swift
//  ClassifiedDemoTests
//
//  Created by Takvir Hossain Tusher on 22/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import XCTest
@testable import ClassifiedDemo

class ClassifiedListViewControllerTest: XCTestCase {
    let presenter = ClassifiedPresenterMock()
    
    func makeView() -> ProductListViewController {
        let view = ProductListViewController()
        view.presenter = presenter
        view.loadViewIfNeeded()
        return view
    }
    
    func testViewDidLoadPresenterCall() {
        let view = makeView()
        view.viewDidLoad()
        
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }

}

class ClassifiedPresenterMock: ProductPresenter {
    
    private (set) var viewDidLoadCalled = false
    
    private (set) var getclassifiedProductsCountCalled = false
    
    func loadViewData() {
        viewDidLoadCalled = true
    }
    
    private (set) var sortClassifiedListCalled = false
    func sortClassifiedList(by property: ClassifiedListSegmentIndex) {
        sortClassifiedListCalled = true
        return
    }
    
    func getclassifiedProductsCount() -> Int {
        getclassifiedProductsCountCalled = true
        return 0
    }
    
    private (set) var getClassifiedItemCalled = false
    
    func getClassifiedItem(at index: Int) -> ClassifiedProduct? {
        getClassifiedItemCalled = true
        return nil
    }
    
    private (set) var onFetchThumbnailCalled = false
    
    func onFetchThumbnail(name: String, completion: @escaping ImageClosure) {
        onFetchThumbnailCalled = true
    }
    
    private (set) var onFetchImageCalled = false
    
    func onFetchImage(name: String, completion: @escaping ImageClosure) {
        onFetchImageCalled = true
    }
    
}

