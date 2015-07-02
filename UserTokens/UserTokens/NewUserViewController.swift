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
        presentingController?.users = users

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

func userNameIsUniqueIn(set: Set<TokensUser>, username: String) -> Bool {
    guard !set.isEmpty else { return true } // any name is unique if collection is empty
    return !set.map({ $0.userName == username }).reduce(false){$0 || $1}
}

func userNameIsEmail(username: NSString) -> Bool {
    return username.localizedCaseInsensitiveContainsString("@") && username.localizedCaseInsensitiveContainsString(".")
}

func isPasswordValid(password: String?)->Bool{
    guard let longer = password?.longerThanEightChars,
        let hasDigit = (password as NSString?)?.containsDecimal else { return false }
    return longer && hasDigit

}

func isUserNameValid(set: Set<TokensUser>, email: String?) -> Bool{
    guard let emailString = email else { return false }
    return userNameIsUniqueIn(set, username: emailString) && userNameIsEmail(emailString)
}


extension NewUserViewController: UITextFieldDelegate {

    func checkForUserNameAndPasswordConformance() -> Bool{
        let validPassword = isPasswordValid(passwordTextField.text)
        let validEmail = isUserNameValid(users, email: emailTextField.text)
        return validPassword && validEmail
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        doneButton.enabled = checkForUserNameAndPasswordConformance()
        textField.resignFirstResponder()
        return true
    }

}