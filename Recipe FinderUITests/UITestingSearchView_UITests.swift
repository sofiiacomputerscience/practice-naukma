//
//  UITestingSearchView_UITests.swift
//  Recipe FinderUITests
//
//  Created by Vladislav Stolyarov on 28.06.2023.
//

import XCTest

final class UITestingSearchView_UITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_SearchView_TextField_shouldSearchRecipes() {
        
        //MARK: GIVEN
        let textField = app.scrollViews.otherElements.containing(.staticText, identifier:"Search recipe by name").children(matching: .textField).element
        let searchLabel = app.scrollViews.otherElements.containing(.staticText, identifier:"Search recipe by name").element
        let cKey = app/*@START_MENU_TOKEN@*/.keys["C"]/*[[".keyboards.keys[\"C\"]",".keys[\"C\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let sKey = app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let rKey = app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        let foundedRecipesViewNavigationBarBackButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Back"]
        let exists = NSPredicate(format: "exists == 1")
        let expectation = self.expectation(for: exists, evaluatedWith: foundedRecipesViewNavigationBarBackButton, handler: nil)
        
        //MARK: WHEN
        textField.tap()
        cKey.tap()
        aKey.tap()
        eKey.tap()
        sKey.tap()
        aKey.tap()
        rKey.tap()
        returnButton.tap()
        
        //MARK: THEN
        waitForExpectations(timeout: 5)
        XCTAssertTrue(foundedRecipesViewNavigationBarBackButton.exists)
    }
    
    func test_SearchView_PizzaButton_shouldSearchRecipes(){
        
        //MARK: GIVEN
        let pizzaButton = app.scrollViews.otherElements.buttons["Pizza"]
        let foundedRecipesViewNavigationBarBackButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Back"]
        let exists = NSPredicate(format: "exists == 1")
        let expectation = self.expectation(for: exists, evaluatedWith: foundedRecipesViewNavigationBarBackButton, handler: nil)
        
        //MARK: WHEN
        pizzaButton.tap()
        
        //MARK: THEN
        waitForExpectations(timeout: 5)
        XCTAssertTrue(foundedRecipesViewNavigationBarBackButton.exists)
        
    }
    
    func test_SearchView_SandwichesButton_shouldSearchRecipes(){
        
        //MARK: GIVEN
        let sandwichesButton = app.scrollViews.otherElements.buttons["Sandwiches"]
        let foundedRecipesViewNavigationBarBackButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Back"]
        let exists = NSPredicate(format: "exists == 1")
        let expectation = self.expectation(for: exists, evaluatedWith: foundedRecipesViewNavigationBarBackButton, handler: nil)
        
        //MARK: WHEN
        sandwichesButton.tap()
        
        //MARK: THEN
        waitForExpectations(timeout: 5)
        XCTAssertTrue(foundedRecipesViewNavigationBarBackButton.exists)
        
    }
    
    func test_SearchView_SoupsButton_shouldSearchRecipes(){

        //MARK: GIVEN
        let soupsButton = app.scrollViews.otherElements.buttons["Soups"]
        let foundedRecipesViewNavigationBarBackButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Back"]
        let exists = NSPredicate(format: "exists == 1")
        let expectation = self.expectation(for: exists, evaluatedWith: foundedRecipesViewNavigationBarBackButton, handler: nil)

        //MARK: WHEN
        soupsButton.tap()

        //MARK: THEN
        waitForExpectations(timeout: 5)
        XCTAssertTrue(foundedRecipesViewNavigationBarBackButton.exists)

    }

    func test_SearchView_PastaButton_shouldSearchRecipes(){

        //MARK: GIVEN
        let pastaButton = app.scrollViews.otherElements.buttons["Pasta"]
        let foundedRecipesViewNavigationBarBackButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Back"]
        let exists = NSPredicate(format: "exists == 1")
        let expectation = self.expectation(for: exists, evaluatedWith: foundedRecipesViewNavigationBarBackButton, handler: nil)

        //MARK: WHEN
        pastaButton.tap()

        //MARK: THEN
        waitForExpectations(timeout: 5)
        XCTAssertTrue(foundedRecipesViewNavigationBarBackButton.exists)

    }

    func test_SearchView_AsianButton_shouldSearchRecipes(){

        //MARK: GIVEN
        let asianButton = app.scrollViews.otherElements.buttons["Asian"]
        let foundedRecipesViewNavigationBarBackButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Back"]
        let exists = NSPredicate(format: "exists == 1")
        let expectation = self.expectation(for: exists, evaluatedWith: foundedRecipesViewNavigationBarBackButton, handler: nil)

        //MARK: WHEN
        asianButton.tap()

        //MARK: THEN
        waitForExpectations(timeout: 5)
        XCTAssertTrue(foundedRecipesViewNavigationBarBackButton.exists)

    }

    func test_SearchView_SeafoodButton_shouldSearchRecipes(){

        //MARK: GIVEN
        let seafoodButton = app.scrollViews.otherElements.buttons["Seafood"]
        let foundedRecipesViewNavigationBarBackButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Back"]
        let exists = NSPredicate(format: "exists == 1")
        let expectation = self.expectation(for: exists, evaluatedWith: foundedRecipesViewNavigationBarBackButton, handler: nil)

        //MARK: WHEN
        seafoodButton.tap()

        //MARK: THEN
        waitForExpectations(timeout: 5)
        XCTAssertTrue(foundedRecipesViewNavigationBarBackButton.exists)

    }

    func test_SearchView_SaladButton_shouldSearchRecipes(){

        //MARK: GIVEN
        let saladButton = app.scrollViews.otherElements.buttons["Salad"]
        let foundedRecipesViewNavigationBarBackButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Back"]
        let exists = NSPredicate(format: "exists == 1")
        let expectation = self.expectation(for: exists, evaluatedWith: foundedRecipesViewNavigationBarBackButton, handler: nil)

        //MARK: WHEN
        saladButton.tap()

        //MARK: THEN
        waitForExpectations(timeout: 5)
        XCTAssertTrue(foundedRecipesViewNavigationBarBackButton.exists)

    }

    func test_SearchView_DessertsButton_shouldSearchRecipes(){

        //MARK: GIVEN
        let dessertsButton = app.scrollViews.otherElements.buttons["Desserts"]
        let foundedRecipesViewNavigationBarBackButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Back"]
        let exists = NSPredicate(format: "exists == 1")
        let expectation = self.expectation(for: exists, evaluatedWith: foundedRecipesViewNavigationBarBackButton, handler: nil)

        //MARK: WHEN
        dessertsButton.tap()

        //MARK: THEN
        waitForExpectations(timeout: 5)
        XCTAssertTrue(foundedRecipesViewNavigationBarBackButton.exists)

    }

    func test_SearchView_VegetarianButton_shouldSearchRecipes(){

        //MARK: GIVEN
        let vegetarianButton = app.scrollViews.otherElements.buttons["Vegetarian"]
        let foundedRecipesViewNavigationBarBackButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Back"]
        let exists = NSPredicate(format: "exists == 1")
        let expectation = self.expectation(for: exists, evaluatedWith: foundedRecipesViewNavigationBarBackButton, handler: nil)

        //MARK: WHEN
        vegetarianButton.tap()

        //MARK: THEN
        waitForExpectations(timeout: 5)
        XCTAssertTrue(foundedRecipesViewNavigationBarBackButton.exists)

    }

    func test_SearchView_DrinksButton_shouldSearchRecipes(){

        //MARK: GIVEN
        let drinksButton = app.scrollViews.otherElements.buttons["Drinks"]
        let foundedRecipesViewNavigationBarBackButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Back"]
        let exists = NSPredicate(format: "exists == 1")
        let expectation = self.expectation(for: exists, evaluatedWith: foundedRecipesViewNavigationBarBackButton, handler: nil)

        //MARK: WHEN
        drinksButton.tap()

        //MARK: THEN
        waitForExpectations(timeout: 5)
        XCTAssertTrue(foundedRecipesViewNavigationBarBackButton.exists)

    }

    func test_SearchView_CocktailsButton_shouldSearchRecipes(){

        //MARK: GIVEN
        let cocktailsButton = app.scrollViews.otherElements.buttons["Cocktails"]
        let foundedRecipesViewNavigationBarBackButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Back"]
        let exists = NSPredicate(format: "exists == 1")
        let expectation = self.expectation(for: exists, evaluatedWith: foundedRecipesViewNavigationBarBackButton, handler: nil)

        //MARK: WHEN
        cocktailsButton.tap()

        //MARK: THEN
        waitForExpectations(timeout: 5)
        XCTAssertTrue(foundedRecipesViewNavigationBarBackButton.exists)

    }

    func test_SearchView_BreakfastButton_shouldSearchRecipes(){

        //MARK: GIVEN
        let breakfastButton = app.scrollViews.otherElements.buttons["Breakfast"]
        let foundedRecipesViewNavigationBarBackButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Back"]
        let exists = NSPredicate(format: "exists == 1")
        let expectation = self.expectation(for: exists, evaluatedWith: foundedRecipesViewNavigationBarBackButton, handler: nil)

        //MARK: WHEN
        breakfastButton.tap()

        //MARK: THEN
        waitForExpectations(timeout: 5)
        XCTAssertTrue(foundedRecipesViewNavigationBarBackButton.exists)

    }
    
}
