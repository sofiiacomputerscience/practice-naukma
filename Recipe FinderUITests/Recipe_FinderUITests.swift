//
//  Recipe_FinderUITests.swift
//  Recipe FinderUITests
//
//  Created by Vladislav Stolyarov on 18.06.2023.
//

import XCTest

final class Recipe_FinderUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }
    
    func test_SearchView_TextField_shouldSearchRecipes() {
                
    }

//    func testSearchingForRecipes() throws {
//        let app = XCUIApplication()
//        app.launch()
//
//        // Assuming that the "Search" tab is the first tab in your TabView
//        app.tabBars.buttons.element(boundBy: 0).tap()
//
//        // Find the TextField in the SearchView
//        let searchField = app.textFields.firstMatch
//        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
//
//        // Check that the magnifying glass image exists
//        let magnifyingGlass = app.images["magnifyingglass"]
//        XCTAssertTrue(magnifyingGlass.exists)
//
//        // Check that the clear button exists
////        let clearButton = app.buttons["xmark.circle.fill"]
////        XCTAssertTrue(clearButton.exists)
//
//        searchField.tap()
//        searchField.typeText("Chicken")
//
//        // Assuming you have a keyboard return key event to trigger the search
//        app.keyboards.buttons["return"].tap()
//
//        // Check that the navigation link is activated (this depends on the exact structure of your app)
//        // You can use predicates to wait for certain conditions to be true
//        let predicate = NSPredicate(format: "exists == 1")
//        let foundedRecipesView = app.otherElements["FoundedRecipesView"]  // Assuming "FoundedRecipesView" is the accessibility identifier for the founded recipes view
//        expectation(for: predicate, evaluatedWith: foundedRecipesView, handler: nil)
//        waitForExpectations(timeout: 5, handler: nil)
//        XCTAssertTrue(foundedRecipesView.exists)
//    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
