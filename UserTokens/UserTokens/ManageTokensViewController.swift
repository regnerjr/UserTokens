import UIKit

class ManageTokensViewController: UIViewController {

    var user: TokensUser! //to be filled in before VC is presented
    var users: Set<TokensUser>! //to be filled in before VC is presented

    @IBOutlet weak var userNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = user?.userName
    }

    //MARK: - Navigation
    @IBAction func done(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
