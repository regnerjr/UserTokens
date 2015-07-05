import XCTest
@testable import UserTokens

class DetailVCTests: XCTestCase {

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
        master = masterNav.topViewController as! MasterViewController
        master.users = NSMutableArray()
        let user = TokensUser(userName: "john@john.com", password: "asdfasdf1234")
        master.users.addObject(user)
        master.archive()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        master.tableView.reloadData()
        XCTAssert(master.users.count == 1)

        let path = NSIndexPath(forItem: 0, inSection: 0)
        master.tableView.selectRowAtIndexPath(path, animated: false, scrollPosition: UITableViewScrollPosition.Top)
        master.tableView.delegate?.tableView!(master.tableView, didSelectRowAtIndexPath: path)

        let detailNav = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("detailNav")
        let segue = UIStoryboardSegue(identifier: "showDetail", source: master, destination: detailNav)
        master.prepareForSegue(segue, sender: nil)
        master.performSegueWithIdentifier("showDetail", sender: nil)

        XCTAssertNotNil(master.detailViewController)

        XCTAssertNotNil(master.detailViewController?.detailItem)

        master.users[0].addToken(NSUUID())
        master.tableView.reloadData()

        master.tableView.selectRowAtIndexPath(path, animated: false, scrollPosition: UITableViewScrollPosition.Top)
        master.tableView.delegate?.tableView!(master.tableView, didSelectRowAtIndexPath: path)


        master.prepareForSegue(segue, sender: nil)
        master.performSegueWithIdentifier("showDetail", sender: nil)


        XCTAssertNotNil(master.detailViewController?.tokensView.text)
        XCTAssertNotEqual(master.detailViewController!.tokensView.text, "")



    }

}
