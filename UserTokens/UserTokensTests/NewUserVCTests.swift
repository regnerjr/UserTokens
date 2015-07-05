import XCTest
@testable import UserTokens

class NewUserVCTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testUniqueUserNames() {
        let userOne = TokensUser(userName: "john@john.com", password: "asdfasdf123")
        let userTwo = TokensUser(userName: "shelby@shelby.com", password: "asdfasdf123")
        let array = NSMutableArray()
        array.addObject(userOne)
        array.addObject(userTwo)

        var valid = isUserNameValid(array, email: "john@john.com")
        XCTAssertFalse(valid)// not valid since it is repeated
        valid = isUserNameValid(array, email: "johnnyAppleseed@apple.com")
        XCTAssertTrue(valid)
    }

    func testPasswordValidation(){
        let empty: String? = nil
        XCTAssertFalse(isPasswordValid(empty))

        let tooShort = "asd1"
        XCTAssertFalse(isPasswordValid(tooShort))

        let noNumber = "asdfasdfasdf"
        XCTAssertFalse(isPasswordValid(noNumber))

        let noAlpha = "12341234"
        XCTAssertFalse(isPasswordValid(noAlpha))

        let valid = "abcd123efg"
        XCTAssertTrue(isPasswordValid(valid))

    }

    func testNameIsEmail(){
        let noAt = "john_regner"
        XCTAssertFalse(userNameIsEmail(noAt))

        let noDot = "john@john"
        XCTAssertFalse(userNameIsEmail(noDot))

        let hasDotNoAt = "john.john"
        XCTAssertFalse(userNameIsEmail(hasDotNoAt))

        let valid = "john@john.com"
        XCTAssertTrue(userNameIsEmail(valid))
    }

    func testNameUniqueness(){


        let addUserVC = UIStoryboard(name: "NewUser", bundle: nil).instantiateInitialViewController() as! NewUserViewController
        addUserVC.users = NSMutableArray()
        let _ = addUserVC.view //loadView

        addUserVC.emailTextField.text = "john@john.com"
        addUserVC.textFieldShouldReturn(addUserVC.emailTextField)
        addUserVC.passwordTextField.text = "asdfasdf123"
        addUserVC.textFieldShouldReturn(addUserVC.passwordTextField)

        let button = UIBarButtonItem()
        addUserVC.done(button)
//        XCTAssert(master.users.count > 0 )
//        master.tableView.reloadData()

        //go back to add user, try to add Same user again should fail
//        master.insertNewObject(addButton)

        addUserVC.emailTextField.text = "john@john.com"
        addUserVC.textFieldShouldReturn(addUserVC.emailTextField)
        addUserVC.passwordTextField.text = "asdfasdf123"
        addUserVC.textFieldShouldReturn(addUserVC.passwordTextField)
        XCTAssertFalse(addUserVC.doneButton.enabled)


    }

    func testCancelReturns(){

//        XCTAssert(master.hasSelection == false)
        let addUserVC = UIStoryboard(name: "NewUser", bundle: nil).instantiateInitialViewController() as! NewUserViewController
        let _ = addUserVC.view
        let users = NSMutableArray()
        addUserVC.users = users

        print("DoneButton State: \(addUserVC.doneButton.enabled)")
        XCTAssertEqual(addUserVC.doneButton.enabled, false) //nothing entered, should not be enabled

        let button = UIBarButtonItem()
        addUserVC.cancel(button)
//        XCTAssert(master.users.count == 0) //no new user is entered
    }

}
