import UIKit

extension Set {
    subscript(position: Int) -> T {
        var index = startIndex
        let dist = distance(startIndex, endIndex)
        if dist < position {
            for var i = 0; i < position; ++i {
                index = index.successor()
            }
        }
        return self[startIndex]
    }
}

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    // TODO: fill this from disk if file exists.
    var users = Set<TokensUser>() //start off with an empty set for new

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
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        self.tableView.reloadData()
        detailViewController?.configureView(nil)
        super.viewWillAppear(animated)
    }

    func insertNewObject(sender: AnyObject) {

        //display the Add new user sheet.
        modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        let newUserForm = UIStoryboard(name: "NewUser", bundle: nil).instantiateInitialViewController() as! NewUserViewController



        newUserForm.users = users
        newUserForm.presentingController = self

        presentViewController(newUserForm, animated: true, completion: nil)

    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = users[indexPath.row]

                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.users = users
                controller.masterController = self
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    

    // MARK: - Table View
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = users[indexPath.row]
        cell.textLabel!.text = object.userName
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            users.remove(users[indexPath.row])
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let user = users[indexPath.row]
        detailViewController?.configureView(user)
        detailViewController?.users = users
    }

}

