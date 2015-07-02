import UIKit

enum UserPasswordErrors: String {
    case usernameNotUnique = "UserName must be unique"
    case passwordNotEightChars = "Password must be longer than Eight Characters"
    case passwordHasNoDigit = "Password must contain a Number"
}

class NewUserViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    @IBOutlet weak var emailTextField: EmailTextField!{
        didSet{ /*unhide and set error string if applicable*/ }
    }
    @IBOutlet weak var passwordTextField: PasswordTextField!{
        didSet{ /*unhide and set error string if applicable*/ }
    }

    var users: Set<TokensUser>!

    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.enabled = false
    }

    @IBAction func done(sender: UIBarButtonItem) {
        //pass back the new user too!
        let pres = presentingViewController as? MasterViewController
        pres?.objects = users

        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func tapGesture(sender: UITapGestureRecognizer) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        doneButton.enabled = checkForUserNameAndPasswordConformance()
    }
}

extension NSString {
    var containsDecimal: Bool {
        let decimals = NSCharacterSet.decimalDigitCharacterSet()
        let parts = self.componentsSeparatedByCharactersInSet(decimals)
        return parts.count > 1
    }
}

extension String {
    var longerThanEightChars: Bool {
        return self.utf16.count > 8
    }
}


extension NewUserViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(textField: UITextField) {
        print("Editing began in \(textField.dynamicType)")
    }
    func textFieldDidEndEditing(textField: UITextField) {
        print("Editing is ending in \(textField.dynamicType)")
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("Called for every key stroke user this to enable the done button")
        return true
    }

    func checkForUserNameAndPasswordConformance() -> Bool{
        guard let longer = passwordTextField.text?.longerThanEightChars,
              let hasDigit = (passwordTextField?.text as NSString?)?.containsDecimal  else { return false }
        return longer && hasDigit
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("Run some code when the enter button is pressed in \(textField.dynamicType)")
        textField.resignFirstResponder()
        doneButton.enabled = checkForUserNameAndPasswordConformance()
        return true
    }

}

class EmailTextField: UITextField {

}

class PasswordTextField: UITextField {

}