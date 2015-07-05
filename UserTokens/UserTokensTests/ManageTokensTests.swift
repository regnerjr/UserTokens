import XCTest
@testable import UserTokens

class ManageTokensTests: XCTestCase {

    let USERNAME = "john@john.com"
    var manageVC: ManageTokensViewController!

    override func setUp() {
        super.setUp()
        manageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ManageTokens") as! ManageTokensViewController
        let user = TokensUser(userName: USERNAME, password: "adsfasdf123")
        manageVC.user = user
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNameIsSetOnLoad() {

        XCTAssertNotNil(manageVC.view) //load the view
        //ensure the label is set
        XCTAssert(manageVC.userNameLabel.text! == USERNAME)

    }

    func testAddTokenTest(){
        XCTAssertNotNil(manageVC.view) //load the view
        XCTAssertNotNil(manageVC.user)

        let button = UIButton()
        manageVC.AddNewToken(button)

        // has a token
        XCTAssert(manageVC.tableView.numberOfRowsInSection(0) == 1)
        let path = NSIndexPath(forItem: 0, inSection: 0)
        let cell = manageVC.tableView(manageVC.tableView, cellForRowAtIndexPath: path)
        XCTAssert(cell.textLabel != "")

        //Test Deletion
        manageVC.tableView(manageVC.tableView, commitEditingStyle: UITableViewCellEditingStyle.Delete, forRowAtIndexPath: path)
        XCTAssert(manageVC.user.tokens.count == 0)

    }

}
