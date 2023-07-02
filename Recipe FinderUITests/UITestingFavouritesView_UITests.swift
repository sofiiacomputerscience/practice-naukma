//
//  UITestingFavouritesView_UITests.swift
//  Recipe FinderUITests
//
//  Created by Vladislav Stolyarov on 30.06.2023.
//

import XCTest

final class UITestingFavouritesView_UITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_FavouritesView_DefaultSettings() {
        
        //MARK: GIVEN
        let favouritesViewTab = app.tabBars["Tab Bar"].buttons["Favorites"]
        let favouritesNavigationBar = app.navigationBars["Favourites"]
        let defaultSortByButton = favouritesNavigationBar/*@START_MENU_TOKEN@*/.buttons["Sort by:, Added Time"]/*[[".otherElements[\"Sort by:, Added Time\"].buttons[\"Sort by:, Added Time\"]",".buttons[\"Sort by:, Added Time\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let defaultSortingOrderButton = favouritesNavigationBar/*@START_MENU_TOKEN@*/.buttons["Newest"]/*[[".otherElements[\"Sort by:, Added Time\"].buttons[\"Newest\"]",".buttons[\"Newest\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let actionSheetCancelButton = app/*@START_MENU_TOKEN@*/.otherElements["Sort Recipes By:"].scrollViews/*[[".otherElements[\"Sort Recipes By:\"].scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.otherElements.buttons["Cancel"]
        
        //MARK: WHEN
        favouritesViewTab.tap()
        
        //MARK: THEN
        XCTAssertTrue(favouritesNavigationBar.exists)
        XCTAssertTrue(defaultSortByButton.exists)
        XCTAssertTrue(defaultSortingOrderButton.exists)
        
    }
    
    func test_FavouritesViewActionShett_ShowsInfo() {
        
        //MARK: GIVEN
        let favouritesViewTab = app.tabBars["Tab Bar"].buttons["Favorites"]
        let favouritesNavigationBar = app.navigationBars["Favourites"]
        let defaultSortByButton = favouritesNavigationBar/*@START_MENU_TOKEN@*/.buttons["Sort by:, Added Time"]/*[[".otherElements[\"Sort by:, Added Time\"].buttons[\"Sort by:, Added Time\"]",".buttons[\"Sort by:, Added Time\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let actionSheetCancelButton = app/*@START_MENU_TOKEN@*/.otherElements["Sort Recipes By:"].scrollViews/*[[".otherElements[\"Sort Recipes By:\"].scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.otherElements.buttons["Cancel"]
        let actionSheetAddedTimeButton = app/*@START_MENU_TOKEN@*/.otherElements["Sort Recipes By:"].scrollViews/*[[".otherElements[\"Sort Recipes By:\"].scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.otherElements.buttons["Added Time"]
        let actionSheetNameButton = app.otherElements["Sort Recipes By:"].scrollViews.otherElements.buttons["Name"]
        let actionSheetCookingTimeButton = app.otherElements["Sort Recipes By:"].scrollViews.otherElements.buttons["Cooking Time"]
        let actionSheetFatButton = app/*@START_MENU_TOKEN@*/.otherElements["Sort Recipes By:"].scrollViews/*[[".otherElements[\"Sort Recipes By:\"].scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.otherElements.buttons["Fat"]
        let actionSheetCarbsButton = app/*@START_MENU_TOKEN@*/.otherElements["Sort Recipes By:"].scrollViews/*[[".otherElements[\"Sort Recipes By:\"].scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.otherElements.buttons["Carbs"]
        let actionSheetProteinButton = app/*@START_MENU_TOKEN@*/.otherElements["Sort Recipes By:"].scrollViews/*[[".otherElements[\"Sort Recipes By:\"].scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.otherElements.buttons["Protein"]
        
        //MARK: WHEN
        favouritesViewTab.tap()
        defaultSortByButton.tap()
        
        //MARK: THEN
        XCTAssertTrue(actionSheetCancelButton.exists)
        XCTAssertTrue(actionSheetAddedTimeButton.exists)
        XCTAssertTrue(actionSheetNameButton.exists)
        XCTAssertTrue(actionSheetCookingTimeButton.exists)
        XCTAssertTrue(actionSheetFatButton.exists)
        XCTAssertTrue(actionSheetCarbsButton.exists)
        XCTAssertTrue(actionSheetProteinButton.exists)
    }
    
    
}
