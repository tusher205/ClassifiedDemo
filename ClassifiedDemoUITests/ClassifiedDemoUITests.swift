//
//  ClassifiedDemoUITests.swift
//  ClassifiedDemoUITests
//
//  Created by Takvir Hossain Tusher on 20/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import XCTest

class ClassifiedDemoUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let emptyListTable = XCUIApplication().tables["Empty list"]
        emptyListTable.swipeUp()
        emptyListTable.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Notebook"]/*[[".cells.staticTexts[\"Notebook\"]",".staticTexts[\"Notebook\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let scrollViewsQuery = app.scrollViews
        let page1Of1ElementsQuery = scrollViewsQuery.otherElements.containing(.pageIndicator, identifier:"page 1 of 1")
        page1Of1ElementsQuery.children(matching: .staticText)["AED 5"].swipeUp()
        
        let scrollView = page1Of1ElementsQuery.children(matching: .scrollView).element
        scrollView.swipeDown()
        
        let classifiedItemsButton = app.navigationBars["Details"].buttons["Classified Items"]
        classifiedItemsButton.tap()
        tablesQuery.cells.containing(.staticText, identifier:"Notebook").staticTexts["AED 5"].swipeLeft()
        classifiedItemsButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Glasses"]/*[[".cells.staticTexts[\"Glasses\"]",".staticTexts[\"Glasses\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let page1Of1Element = scrollViewsQuery.otherElements.containing(.pageIndicator, identifier:"page 1 of 1").element
        page1Of1Element.swipeUp()
        classifiedItemsButton.tap()
        
        let monitorStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Monitor"]/*[[".cells.staticTexts[\"Monitor\"]",".staticTexts[\"Monitor\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        monitorStaticText.tap()
        page1Of1Element.swipeUp()
        classifiedItemsButton.tap()
        monitorStaticText.swipeLeft()
        scrollView.swipeRight()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Acoustic Guitar"]/*[[".cells.staticTexts[\"Acoustic Guitar\"]",".staticTexts[\"Acoustic Guitar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        scrollView.swipeRight()
        scrollView.swipeRight()
        scrollView.swipeRight()
        scrollView.swipeDown()
        classifiedItemsButton.tap()
        
        let hatStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Hat"]/*[[".cells.staticTexts[\"Hat\"]",".staticTexts[\"Hat\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hatStaticText.swipeUp()
        classifiedItemsButton.tap()
        hatStaticText.tap()
        classifiedItemsButton.tap()
        tablesQuery.children(matching: .cell).element(boundBy: 4).staticTexts["Pen"].swipeUp()
                                                
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
