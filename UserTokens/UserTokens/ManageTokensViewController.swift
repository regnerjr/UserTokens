import UIKit

class ManageTokensViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var user: TokensUser! //to be filled in before VC is presented
    var users: Set<TokensUser>! //to be filled in before VC is presented

    @IBOutlet weak var userNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = user?.userName
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

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.tokens.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TokenCell", forIndexPath: indexPath)
        cell.textLabel?.text = user.tokens[indexPath.row].UUIDString
        return cell
    }

}
