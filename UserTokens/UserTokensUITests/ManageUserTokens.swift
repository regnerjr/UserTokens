import Foundation
import XCTest

class ManageUserTokens: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        //create a user and navigate to the Master List
        app = XCUIApplication()
        app.navigationBars["Users"].buttons["Add"].tap()

        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("john@john.com")
        app.buttons["Return"].tap()

        let password1TextField = app.textFields["Password1"]
        password1TextField.tap()
        password1TextField.typeText("asdfasdf1")
        app.buttons["Return"].tap()

        app.toolbars.buttons["Done"].tap()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCanAddTokens() {

        app.tables.staticTexts["john@john.com"].tap()
        app.buttons["ManageTokens"].tap()

        XCUIApplication().buttons["AddNewToken"].tap()

        //assert new token has been added to the table
        XCTAssertEqual(app.tables.cells.count, 1)

        //Remove Token
        let tokenCell = app.tables.cells.elementAtIndex(0)
        tokenCell.swipeLeft()
        XCUIApplication().tables.buttons["Delete"].tap()

        // Token should be Gone
        XCTAssertEqual(app.tables.cells.count, 0)

        XCUIApplication().buttons["AddNewToken"].tap()
        XCTAssertEqual(app.tables.cells.count, 1)

        app.toolbars.buttons["Done"].tap()

        //token should now be in the tokensTextField
        let tokensList = app.textViews.elementAtIndex(0)
        XCTAssertEqual(tokensList.exists, true)
        XCTAssertNotEqual(tokensList.value as! String, "") //should have something in it
    }

    func testAddedTokensPersist(){

        app.tables.staticTexts["john@john.com"].tap()
        app.buttons["ManageTokens"].tap()

        XCUIApplication().buttons["AddNewToken"].tap()

        //assert new token has been added to the table
        XCTAssertEqual(app.tables.cells.count, 1)

        app.toolbars.buttons["Done"].tap()
        app.navigationBars.matchingIdentifier("User Details").buttons["Users"].tap()
        app.tables.staticTexts["john@john.com"].tap()

        let tokensList = app.textViews.elementAtIndex(0)
        XCTAssertEqual(tokensList.exists, true)
        XCTAssertNotEqual(tokensList.value as! String, "") //should have something in it

    }

}
