import XCTest
@testable import UserTokens

class MasterVCTests: XCTestCase {

    var ad: AppDelegate!
    var window: UIWindow!
    var rvc: UISplitViewController!
    var masterNav: UINavigationController!
    var master: MasterViewController!

    override func setUp() {
        super.setUp()
        ad = UIApplication.sharedApplication().delegate as! AppDelegate
        window = ad.window!
        rvc = window.rootViewController as! UISplitViewController
        masterNav = rvc.viewControllers[0] as! UINavigationController
        if masterNav.viewControllers.count == 2 {
            if masterNav.viewControllers[0].dynamicType == UserTokens.MasterViewController {
                master = masterNav.viewControllers[0] as! MasterViewController
            } else if masterNav.viewControllers[1].dynamicType == UserTokens.MasterViewController {
                master = masterNav.viewControllers[1] as! MasterViewController
            } else {
                print("MasterNav has \(masterNav.viewControllers.count) VCs")
                fatalError("MasterViewController Could not be found")
            }
        } else if masterNav.viewControllers.count == 1{ // if only one assume it is the masterVC
            master = masterNav.viewControllers[0] as! MasterViewController
        }
        master.users = NSMutableArray()
        let user = TokensUser(userName: "john@john.com", password: "asdfasdf123")
        master.users.addObject(user)
        master.archive()

    }

    override func tearDown() {
        master.users = NSMutableArray()
        master.archive()
        super.tearDown()
    }

    func testMasterVC() {
        if var ips = master.tableView.indexPathsForSelectedRows {
            while ips.count > 0 {
                master.tableView.deselectRowAtIndexPath(ips[0], animated: false)
                ips.removeAtIndex(0)
            }
        }
        XCTAssert(master.hasSelection == false)
        XCTAssert(master.users.count > 0 ) //new user exists

        master.tableView.reloadData()

        let path = NSIndexPath(forItem: 0, inSection: 0)
        let cell = master.tableView(master.tableView, cellForRowAtIndexPath: path)
        XCTAssert(cell.textLabel!.text == "john@john.com")

        master.tableView.selectRowAtIndexPath(path, animated: false, scrollPosition: UITableViewScrollPosition.Top)
        master.tableView.delegate!.tableView!(master.tableView, didSelectRowAtIndexPath: path)

        let detail = master.detailViewController
        XCTAssertTrue(master.users == detail!.users)
        XCTAssertTrue(detail!.detailItem! == (master.users[0] as! TokensUser))

        //Remove the first cell
        master.tableView(master.tableView, commitEditingStyle: UITableViewCellEditingStyle.Delete, forRowAtIndexPath: path)
        XCTAssert(master.users.count == 0)
        XCTAssert(master.tableView.numberOfRowsInSection(0) == 0)

        //add a user back
        let newUser = TokensUser(userName: "some@name.com", password: ";lk;lkj123")
        master.users.addObject(newUser)
        master.archive()

        XCTAssert(master.users.count > 0 ) //new user exists
        //can we archive our users
        master.archive()

        // read the archive it should have one TokensUser in it
        let restored = NSKeyedUnarchiver.unarchiveObjectWithFile(Archive.path!) as! NSMutableArray
        XCTAssert(restored.count == 1)
    }


}
