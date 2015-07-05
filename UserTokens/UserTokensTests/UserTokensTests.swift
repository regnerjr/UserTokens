import XCTest
@testable import UserTokens

class UserTokensTests: XCTestCase {

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
        } else if masterNav.viewControllers.count == 1 { // if only one assume it is the masterVC
            master = masterNav.viewControllers[0] as! MasterViewController
        }

        master.users = NSMutableArray()
        master.archive()

    }
    
    override func tearDown() {
        master.users = NSMutableArray()
        master.archive()
        super.tearDown()
    }

}
