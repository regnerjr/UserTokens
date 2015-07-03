import UIKit

class ManageTokensViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var user: TokensUser! //to be filled in before VC is presented
//    var users: Set<TokensUser>! //to be filled in before VC is presented

    @IBOutlet weak var userNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = user?.userName.description
        print(user)
    }

    
    @IBAction func AddNewToken(sender: UIButton) {
        user.addToken()
        tableView.reloadData()
    }

    //MARK: - Navigation
    @IBAction func done(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    //MARK: - TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.tokens.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TokenCell", forIndexPath: indexPath)
        cell.textLabel?.text = user.tokens[indexPath.row].UUIDString
        return cell
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            user.tokens.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }

    }

}
