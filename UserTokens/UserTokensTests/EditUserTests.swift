import XCTest
@testable import UserTokens

class EditUserTests: XCTestCase {

    let USERNAME = "john@john.com"
    let PASSWORD = "asdfasdf123"
    let ID = NSUUID()
    var editVC: EditUserViewController!
    var firstUser: TokensUser!

    override func setUp() {
        super.setUp()
        editVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("EditUser") as! EditUserViewController
        firstUser = TokensUser(userName: USERNAME, password: PASSWORD, id: ID, tokens: [NSUUID](), lastUpdated: NSDate())
        editVC.user = firstUser
        let array = NSMutableArray()
        array.addObject(firstUser)
        editVC.users = array

    }

    override func tearDown() {
        super.tearDown()
    }

    func testLoadView() {
        XCTAssertNotNil(editVC.view) //load the view
        //ensure the label is set
        XCTAssert(editVC.userNameField.text! == USERNAME)
        XCTAssert(editVC.passwordField.text! == PASSWORD)
        XCTAssert(editVC.idLabel.text! == ID.UUIDString)

    }

    func testNewID(){
        let _ = editVC.view //load the view
        let button = UIButton()

        editVC.newID(button)

        XCTAssert(editVC.idLabel.text != ID.UUIDString)
        XCTAssert(editVC.user != firstUser)
        XCTAssertFalse(editVC.users.containsObject(firstUser))

    }

    func testGoodConformance(){
        let _ = editVC.view //load the view

        editVC.userNameField.text = "shelby@shelby.com"
        editVC.passwordField.text = "asdfasdf123"

        XCTAssert(editVC.checkForEmailConformance())
        XCTAssert(editVC.checkForPasswordConformance())
        XCTAssert(editVC.checkForUserNameAndPasswordConformance())

        editVC.userNameField.text = "shelby"
        editVC.passwordField.text = "asdfasdf"

        XCTAssertFalse(editVC.checkForEmailConformance())
        XCTAssertFalse(editVC.checkForPasswordConformance())
        XCTAssertFalse(editVC.checkForUserNameAndPasswordConformance())
    }

    func testUpdateUser(){
        let _ = editVC.view //load the view

        editVC.userNameField.text = "shelby@shelby.com"
        editVC.passwordField.text = "zxcdzxcv123"
        editVC.updateUser()

        let newUser = (editVC.users[0] as! TokensUser)
        XCTAssert(newUser.userName != USERNAME)//new username
        XCTAssert(newUser.password != PASSWORD)//new password
        XCTAssert(newUser.lastUpdated != firstUser.lastUpdated)

    }
    func testEndEditing(){
        let _ = editVC.view //load the view

        editVC.passwordField.text = "123asdfasdf"
        editVC.textFieldDidEndEditing(editVC.passwordField)

        var updatedUser = editVC.users[0] as! TokensUser
        XCTAssert(updatedUser.password == "123asdfasdf")

        editVC.userNameField.text = "john@johnregner.com"
        editVC.textFieldDidEndEditing(editVC.userNameField)

        updatedUser = editVC.users[0] as! TokensUser
        XCTAssert(updatedUser.userName == "john@johnregner.com")


    }

}
