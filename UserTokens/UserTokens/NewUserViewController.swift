import UIKit

enum UserPasswordErrors: String {
    case usernameNotUnique = "UserName must be unique"
    case passwordNotEightChars = "Password must be longer than Eight Characters"
    case passwordHasNoDigit = "Password must contain a Number"
}

class EmailTextField: UITextField {}
class PasswordTextField: UITextField {}

class NewUserViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    @IBOutlet weak var emailTextField: EmailTextField!{
        didSet{ /*unhide and set error string if applicable*/ }
    }
    @IBOutlet weak var passwordTextField: PasswordTextField!{
        didSet{ /*unhide and set error string if applicable*/ }
    }

    weak var presentingController: MasterViewController?

    var users: Set<TokensUser>!

    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.enabled = false
    }

    @IBAction func done(sender: UIBarButtonItem) {
        guard let name = emailTextField.text, let pass = passwordTextField.text else { return }
        let newUser = TokensUser(userName: name, password: pass)
        users.insert(newUser)
        //pass back the new user too!
        presentingController?.objects = users

        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func tapGesture(sender: UITapGestureRecognizer) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        doneButton.enabled = checkForUserNameAndPasswordConformance()
    }
}



extension NewUserViewController: UITextFieldDelegate {

    func userNameIsUniqueIn(set: Set<TokensUser>, username: String) -> Bool {
        guard !set.isEmpty else { return true } // any name is unique if collection is empty
        return !set.map({ $0.userName == username }).reduce(false){$0 || $1}
    }

    func userNameIsEmail(username: NSString) -> Bool {
        return username.localizedCaseInsensitiveContainsString("@") && username.localizedCaseInsensitiveContainsString(".")
    }

    func checkForUserNameAndPasswordConformance() -> Bool{
        guard let longer = passwordTextField.text?.longerThanEightChars,
              let hasDigit = (passwordTextField?.text as NSString?)?.containsDecimal,
              let emailString = emailTextField.text
        else { return false }
        return longer && hasDigit && userNameIsUniqueIn(users, username: emailString) && userNameIsEmail(emailString)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        doneButton.enabled = checkForUserNameAndPasswordConformance()
        return true
    }

}