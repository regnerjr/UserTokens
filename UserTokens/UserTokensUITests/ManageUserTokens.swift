import Foundation
import XCTest

class ManageUserTokens: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
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
        app.tables.staticTexts["john@john.com"].tap()
        app.buttons["ManageTokens"].tap()

        XCUIApplication().buttons["AddNewToken"].tap()

        //assert new token has been added to the table
        XCTAssertEqual(app.tables.cells.count, 1)

        //Remove Token
        // Not sure how to perform a swipe to delete to get the table delet button to show.

        app.toolbars.buttons["Done"].tap()
        app.navigationBars.matchingIdentifier("User Details").buttons["Users"].tap()
        app.tables.staticTexts["john@john.com"].tap()

        // Token should be visible
        XCTAssertEqual(app.tables.cells.count, 1)




    }
    
}
