import Foundation
import XCTest

class UserTokensUITests: XCTestCase {
    var app: XCUIApplication! = nil

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddUserButtonShowsUserSheet() {

        let addButton = app.navigationBars["Users"].buttons["Add"]
        addButton.tap()
        app.toolbars.buttons["Cancel"].tap()
        addButton.tap()
        // We can cancel a user add
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("john@john.com")
        app.windows.layoutAreas
        //testsGestureRecognizer
        XCUIApplication().staticTexts["UserName"].tap()
        
        let password1TextField = app.textFields["Password1"]
        password1TextField.tap()
        password1TextField.typeText("asdfasdf") // not a valid password
        app.keyboards.buttons["Return"].tap()

        //check that done is not enabled
        XCTAssertEqual(app.buttons["Done"].enabled, false)

        password1TextField.tap()
        password1TextField.typeText("123")
        app.keyboards.buttons["Return"].tap()


        //check that done is enabled
        XCTAssertEqual(app.buttons["Done"].enabled, true)

        emailTextField.tap()
        emailTextField.tap()
        app.menuItems["Select All"].tap()
        app.menuItems["Cut"].tap()
        emailTextField.typeText("john")
        app.typeText("\n")


        //check that done button is disabled
        XCTAssertEqual(app.buttons["Done"].enabled, false)

        emailTextField.tap()
        emailTextField.tap()
        app.menuItems["Select All"].tap()
        app.menuItems["Cut"].tap()

        emailTextField.typeText("john@john.com") //not a valid email
        app.keyboards.buttons["Return"].tap()

        //click done button
        XCUIApplication().toolbars.buttons["Done"].tap()

        //check that john@john.com is now in master list
        XCUIApplication().tables.staticTexts["john@john.com"].tap()

    }

}
