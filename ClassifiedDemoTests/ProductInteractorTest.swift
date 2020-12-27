//
//  ProductListInteractorTest.swift
//  ClassifiedDemoTests
//
//  Created by Takvir Hossain Tusher on 28/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import XCTest
@testable import ClassifiedDemo

class ProductListInteractorTest: XCTestCase {
    
    func testFetchClassifiedItems() {
        let interactor = ProductListInteractor(service: ClassifiedService.shared)
        
        let expectation = XCTestExpectation(description: "Fetching items from server")
        interactor.fetchClassifiedItems(completion: { (response) in
            XCTAssertTrue(response.results?.count ?? 0 > 0)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10)
    }
}

class ImageInteractorTest: XCTestCase {
    
    func testFetchThumbnail() {
        let interactor = ImageInteractor(service: ClassifiedService.shared)
        
        let expectation = XCTestExpectation(description: "Fetching thumbnail from server")
        interactor.fetchThumbnail(name: "https://dummyimage.com/300/09f/fff.png", completion: { (response) in
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testFetchImage() {
        let interactor = ImageInteractor(service: ClassifiedService.shared)
        
        let expectation = XCTestExpectation(description: "Fetching thumbnail from server")
        interactor.fetchImage(name: "https://dummyimage.com/300/09f/fff.png", completion: { (response) in
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10)
    }
}

class HttpRouterTest: XCTestCase {
    func testClassifiedHttpRouterRequest() {
        do {
            _ = try ClassifiedHttpRouter
                .getClassifiedItems
                .request(usingHttpService: ClassifiedHttpService())
            
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testImageHttpRouterDownloadThumbnail() {
        let expectation = XCTestExpectation(description: "Fetching thumbnail from server")
        
        do {
            _ = try ImageHttpRouter
            .downloadThumbnail(imageName: "https://dummyimage.com/300/09f/fff.png")
            .download(using: ImageHttpService(), completion: { (response) in
                expectation.fulfill()
            })
        } catch {
            XCTAssertTrue(false)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testImageHttpRouterDownloadImage() {
        let expectation = XCTestExpectation(description: "Fetching image from server")
        
        do {
            _ = try ImageHttpRouter
            .downloadImage(imageName: "https://dummyimage.com/300/09f/fff.png")
            .download(using: ImageHttpService(), completion: { (response) in
                expectation.fulfill()
            })
        } catch {
            XCTAssertTrue(false)
        }
        
        wait(for: [expectation], timeout: 5)
    }
}

