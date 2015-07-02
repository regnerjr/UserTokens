import UIKit

class NavDelegate: NSObject, UINavigationControllerDelegate {

    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController is MasterViewController {
            (viewController as! MasterViewController).tableView.reloadData()
        }
    }

}
