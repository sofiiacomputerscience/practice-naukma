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
        let favouritesViewTab = app.tabBars["Tab Bar"].buttons["Favorites"]
        let favouritesNavigationBar = app.navigationBars["Favourites"]
        let defaultSortByButton = favouritesNavigationBar/*@START_MENU_TOKEN@*/.buttons["Sort by:, Added Time"]/*[[".otherElements[\"Sort by:, Added Time\"].buttons[\"Sort by:, Added Time\"]",".buttons[\"Sort by:, Added Time\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    }
    
    
}
