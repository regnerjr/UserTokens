import UIKit

class EditUserViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var idLabel: UILabel!

    @IBOutlet weak var doneButton: UIBarButtonItem!

    var user: TokensUser! // Must be configured in prepare for segue
    var users: NSMutableArray! //must be configured in prepare for segue

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView() {
        if user != nil {
            userNameField.text = user.userName as String
            passwordField.text = user.password as String
            idLabel.text = user.id.UUIDString
        }
    }

    // MARK: - Actions
    @IBAction func newID(sender: UIButton) {
        let newID = NSUUID()
        idLabel.text = newID.UUIDString
        users.removeObject(user)
        user = TokensUser(userName: user.userName as String, password: user.password as String, id: newID, tokens: user.tokens, lastUpdated: NSDate())
        users.addObject(user)
    }
    @IBAction func backgroundTapped(sender: UITapGestureRecognizer) {
        if userNameField.isFirstResponder() {
            checkForEmailConformance()
            userNameField.resignFirstResponder()
        }
        if passwordField.isFirstResponder(){
            checkForPasswordConformance()
            passwordField.resignFirstResponder()
        }
    }
}


extension EditUserViewController: UITextFieldDelegate {

    func checkForEmailConformance() -> Bool {
        let validEmail = isUserNameValid(users, email: userNameField.text)
        if validEmail == false {
            //show popup about password requirements
            let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            let OK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alert.title = "Usernames Validation Fail"
            alert.message = "Must be Unique and contain '@' and '.' characters"
            alert.addAction(OK)
            presentViewController(alert, animated: true, completion: nil)
            return false
        }
        return true
    }

    func checkForPasswordConformance() -> Bool{
        let validPassword = isPasswordValid(passwordField.text)
        if validPassword == false {
            //show popup about requrements for usernames
            let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            let OK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(OK)
            alert.title = "Password Validation Fail"
            alert.message = "Must be longer than 8 characters and contain a number"
            presentViewController(alert, animated: true, completion: nil)
            return false
        }
        return true
    }

    func checkForUserNameAndPasswordConformance() -> Bool{
        return checkForPasswordConformance() && checkForEmailConformance()
    }

    func updateUser(){
        users.removeObject(user)
        user.lastUpdated = NSDate()
        user.userName = userNameField.text!
        user.password = passwordField.text!
        users.addObject(user)
    }

    func textFieldDidEndEditing(textField: UITextField) {
        if textField == passwordField && checkForPasswordConformance() {
                updateUser()
        } else if textField == userNameField && checkForEmailConformance() {
                updateUser()
        }
    }
}