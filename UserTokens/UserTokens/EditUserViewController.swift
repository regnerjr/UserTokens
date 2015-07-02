import UIKit

class EditUserViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var idLabel: UILabel!

    @IBOutlet weak var doneButton: UIBarButtonItem!

    var user: TokensUser! // Must be configured in prepare for segue
    var users: Set<TokensUser>! //must be configured in prepare for segue 

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView() {
        if user != nil {
            userNameField.text = user.userName
            passwordField.text = user.password
            idLabel.text = user.id.UUIDString
        }
    }

    // MARK: - Actions
    @IBAction func newID(sender: UIButton) {
        let newID = NSUUID()
        idLabel.text = newID.UUIDString
        users.remove(user)
        user = TokensUser(userName: user.userName, password: user.password, id: newID, tokens: user.tokens, lastUpdated: NSDate())
        users.insert(user)
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
        users.remove(user)
        user.lastUpdated = NSDate()
        user.userName = userNameField.text!
        user.password = passwordField.text!
        users.insert(user)
    }

    func textFieldDidEndEditing(textField: UITextField) {
        if textField == passwordField && checkForPasswordConformance() {
                updateUser()
        } else if textField == userNameField && checkForEmailConformance() {
                updateUser()
        }
    }
}