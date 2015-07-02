import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var updatedlabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!

    @IBOutlet weak var tokensView: UITextView!
    @IBOutlet weak var stack: UIStackView?

    @IBOutlet weak var editUserButton: UIBarButtonItem!
    weak var masterController: MasterViewController?

    lazy var dateFormatter: NSDateFormatter = {
        let fmt = NSDateFormatter()
        fmt.timeStyle = NSDateFormatterStyle.ShortStyle
        fmt.dateStyle = NSDateFormatterStyle.MediumStyle
        return fmt
    }()

    var detailItem: TokensUser? {
        willSet (user){
            if user == nil {
                //hide all UI
                view?.hidden = true
                editUserButton.enabled = false
                return
            } else {
                view?.hidden = false
                editUserButton.enabled = true
            }
            emailLabel.text = user?.userName
            passwordLabel.text = user?.password
            idLabel.text = user?.id.UUIDString

            if user?.tokens.count > 0 {
                tokensView.text = user!.tokens.map{ (token:NSUUID) -> String in token.UUIDString}.reduce(""){$0 + "\n" + $1}
            } else {
                tokensView.text = ""
            }

        guard let creation = user?.dateCreated, updated = user?.lastUpdated else { return }
            createdLabel.text = dateFormatter.stringFromDate(creation)
            updatedlabel.text = dateFormatter.stringFromDate(updated)
        }
    }

    func configureView(user: TokensUser?) {
        // Update the user interface for the detail item.
        detailItem = user
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func manageTokes(sender: AnyObject) {
        print("Manage Tokens Pressed, This will load another View Modally to add and remove tokens from a user.")
    }

    @IBAction func editUser(sender: AnyObject) {
        // push some new UI To edit the user
        print("Pusing some new VC to edit the UserDetails")
    }


}

