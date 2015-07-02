import Foundation
import XCTest

class UserTokensUITests: XCTestCase {
    var app: XCUIApplication! = nil
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
        app.keyboards.buttons["Return"].tap()
        
        let password1TextField = app.textFields["Password1"]
        password1TextField.tap()
        password1TextField.typeText("asdfasdf") // not a valid password
        app.keyboards.buttons["Return"].tap()

        //check that done is not enabled
        XCTAssertEqual(app.buttons["Done"].enabled, false)

<<<<<<< HEAD
        password1TextField.doubleTap()
        let keyboard = app.keyboards.elementAtIndex(0)
//        keyboard.typeKey(XCUIKeyboardKeyDelete, modifierFlags: XCUIKeyModifierFlags.None)

        app.menuItems["Select All"].tap()
        app.menuItems["Cut"].tap()


        password1TextField.typeText("asdfasdf123")
        app.childrenMatchingType(.Window).elementAtIndex(0)
            .childrenMatchingType(.Unknown).elementAtIndex(0)
            .childrenMatchingType(.Unknown).elementAtIndex(0).tap()
=======
        password1TextField.tap()
        password1TextField.typeText("123")
        app.keyboards.buttons["Return"].tap()

>>>>>>> Added More Tests
        //check that done is enabled
        XCTAssertEqual(app.buttons["Done"].enabled, true)

        emailTextField.tap()
<<<<<<< HEAD
        emailTextField.typeText("john") //not a valid email
        app.childrenMatchingType(.Window).elementAtIndex(0)
            .childrenMatchingType(.Unknown).elementAtIndex(0)
            .childrenMatchingType(.Unknown).elementAtIndex(0).tap()
=======
        emailTextField.tap()
        app.menuItems["Select All"].tap()
        app.menuItems["Cut"].tap()
        emailTextField.typeText("john")
        app.typeText("\n")

        
>>>>>>> Added More Tests
        //check that done button is disabled
        XCTAssertEqual(app.buttons["Done"].enabled, false)

        emailTextField.tap()
        emailTextField.tap()
        app.menuItems["Select All"].tap()
        app.menuItems["Cut"].tap()

        emailTextField.typeText("john@john.com") //not a valid email
<<<<<<< HEAD
        app.childrenMatchingType(.Window).elementAtIndex(0)
            .childrenMatchingType(.Unknown).elementAtIndex(0)
            .childrenMatchingType(.Unknown).elementAtIndex(0).tap()
=======
        app.keyboards.buttons["Return"].tap()
>>>>>>> Added More Tests

        //click done button
        XCUIApplication().toolbars.buttons["Done"].tap()

        //check that john@john.com is now in master list
<<<<<<< HEAD
        let list = app.tables.elementAtIndex(0)
        let name = list.cells.elementAtIndex(0).staticTexts.elementAtIndex(0)

=======
        XCUIApplication().tables.staticTexts["john@john.com"].tap()
>>>>>>> Added More Tests
    }


}
