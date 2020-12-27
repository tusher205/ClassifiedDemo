//
//  ClassifiedDemoTests.swift
//  ClassifiedDemoTests
//
//  Created by Takvir Hossain Tusher on 20/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import XCTest
@testable import ClassifiedDemo

class ClassifiedDemoTests: XCTestCase {

    var classifiedInteractor: ProductInteractor?
    var imageInteractor: ImageInteractor?
    
    override func setUp() {
        classifiedInteractor = ProductListInteractor(service: ClassifiedService.shared)
        imageInteractor = ImageInteractor(service: ClassifiedService.shared)
    }
    
    override func tearDown() {
        classifiedInteractor = nil
        imageInteractor = nil
    }
    
    func testClassifiedListInitialization() {
        let viewController = ProductListBuilder.build()
        XCTAssertNotNil(viewController)
        
        let router = ProductListRouter(view: viewController)
        XCTAssertNotNil(router)
        
        let view = ProductListViewController()
        XCTAssertNotNil(view)
        
        if let interactor1 = classifiedInteractor, let interactor2 = imageInteractor {
            let presenter = ProductListPresenter(view: view,
                                                    
                router: router, useCase: (
                                            fetchItems: interactor1.fetchClassifiedItems,
                                            fetchThumbnail: interactor2.fetchThumbnail,
                                            fetchImage: interactor2.fetchImage
            ))
            XCTAssertNotNil(presenter)
        }
        
    }
    
    func testInteractorInitialization() {
        // Test classified interactor
        XCTAssertNotNil(classifiedInteractor)
        
        // Test image interactor
        XCTAssertNotNil(imageInteractor)
    }
    
    func testModel() {
        let model = ClassifiedResponse()
        XCTAssert(model.results?.count == 0)
        XCTAssertNotNil(model.pagination)
        
        let pagination = Pagination()
        XCTAssertNotNil(pagination)
        XCTAssert(pagination.key?.count == 0)
    }
    
    func testServiceInitialization() {
        let httpService = ClassifiedHttpService()
        XCTAssertNotNil(httpService)
    }
    
    func testDateUtils() {
        let dateUtils = DateUtils()
        XCTAssertNotNil(dateUtils)
        
        let date = DateUtils.getFormatedDateFromString("2019-02-24 04:04:17.566515")
        XCTAssertTrue(date.count > 0)
    }
    
    func testGetFormatedDateFromString() {
        let dateUtils = DateUtils()
        XCTAssertNotNil(dateUtils)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = String("yyyy-MM-dd HH:mm:ss")
        
        let date = DateUtils.getDateFromFormatter(dateFormatter, "2019-02-24 04:04:17.566515")
        XCTAssertTrue(date != nil)
    }
}
