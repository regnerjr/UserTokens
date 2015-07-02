import UIKit

extension Set {
    subscript(position: Int) -> T {
        var index = startIndex
        for var i = 0; i < position; ++i {
            index = index.successor()
        }
        guard index <= endIndex else { return self[endIndex] }
        return self[index]
    }
}

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = Set<TokensUser>()

    var hasSelection : Bool {
        if tableView.indexPathsForSelectedRows == nil { return false }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
            detailViewController?.masterController = self
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        self.tableView.reloadData()
        super.viewWillAppear(animated)
        detailViewController?.configureView(nil)
    }

    func insertNewObject(sender: AnyObject) {

        //display the Add new user sheet.
        self.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        let newUserForm = UIStoryboard(name: "NewUser", bundle: nil).instantiateInitialViewController() as! NewUserViewController

        newUserForm.users = objects
        newUserForm.presentingController = self

        self.presentViewController(newUserForm, animated: true, completion: nil)

    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]

                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object.userName
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.remove(objects[indexPath.row])
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let user = objects[indexPath.row]
        detailViewController?.configureView(user)
    }

}

