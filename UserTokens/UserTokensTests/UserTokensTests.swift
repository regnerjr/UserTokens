import XCTest
@testable import UserTokens

class UserTokensTests: XCTestCase {

    var ad: AppDelegate!
    var window: UIWindow!
    var rvc: UISplitViewController!
    var masterNav: UINavigationController!

    override func setUp() {
        super.setUp()
        ad = UIApplication.sharedApplication().delegate as! AppDelegate
        window = ad.window!
        rvc = window.rootViewController as! UISplitViewController
        masterNav = rvc.viewControllers[0] as! UINavigationController

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMasterVC() {
        let master = masterNav.topViewController as! MasterViewController
        XCTAssert(master.hasSelection == false)
        let addButton = master.navigationItem.rightBarButtonItem!
        master.insertNewObject(addButton)
        XCTAssert(master.presentedViewController != nil)

        let addUserVC = master.presentedViewController! as! NewUserViewController
        addUserVC.emailTextField.text = "john@john.com"
        addUserVC.textFieldShouldReturn(addUserVC.emailTextField)
        addUserVC.passwordTextField.text = "asdfasdf123"
        addUserVC.textFieldShouldReturn(addUserVC.passwordTextField)
        XCTAssert(addUserVC.doneButton.enabled == true)

        let button = UIBarButtonItem()
        addUserVC.done(button)
        XCTAssert(master.users.count > 0 )
        master.tableView.reloadData()
        //back to mainVC Select the first item
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        master.tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.Top)
        XCTAssert( master.hasSelection == true )

        XCTAssert(master.users[0].userName == "john@john.com")
        XCTAssert(master.users[5].userName == "john@john.com")
        //falls back to returning the first item in the set

        master.performSegueWithIdentifier("showDetail", sender: master)

        //assert something here

    }

    

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
