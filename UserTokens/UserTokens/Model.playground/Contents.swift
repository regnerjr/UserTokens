import UIKit

extension NSUUID: CustomPlaygroundQuickLookable {
    public func customPlaygroundQuickLook() -> PlaygroundQuickLook {
        return PlaygroundQuickLook.Text(self.UUIDString)
    }
}
extension NSUUID: CustomDebugStringConvertible {
    public override var debugDescription: String {
        return self.UUIDString
    }
}


protocol User {
    var id: NSUUID {get}
    var userName: String {get}
}

struct TokensUser: User, Hashable {
    let id: NSUUID
    let userName: String
    let password: String
    var tokens : [NSUUID] //Token string should be at least 20 characters and unique

    mutating func addToken(newToken: NSUUID = NSUUID()){
        tokens.append(newToken)
    }
    mutating func removeToken(token: NSUUID) {
        tokens = tokens.filter{$0 != token}
    }
    var hashValue: Int {
        return "\(id) \(userName)".hashValue
    }
}
extension TokensUser: Equatable {}
func ==(lhs: TokensUser, rhs: TokensUser) -> Bool {
    return lhs.id == rhs.id
}

var users = Set<TokensUser>()

// User can be created, updated, and deleted
//createNewUserIn()
//updateUserIn()
//deleteUserIn()

// Auto-generated token can be added to a user.

//Password should be at least 8 characters long and contain at least one numeric character
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

func userNameIsUniqueIn(set: Set<TokensUser>, username: String) -> Bool {
    guard !set.isEmpty else { return true } // any name is unique if collection is empty
    return !set.map({ $0.userName == username }).reduce(false){$0 || $1}
}

func userNameIsEmail(username: NSString) -> Bool {
    return username.localizedCaseInsensitiveContainsString("@") && username.localizedCaseInsensitiveContainsString(".")
}

func passwordIsValid(password: String) -> Bool{
    return password.longerThanEightChars && password.containsDecimal
}

func createNewUser(username: String, password: String, set: Set<TokensUser>) -> TokensUser? {
    guard userNameIsUniqueIn(set, username: username)
        && userNameIsEmail(username)
        && passwordIsValid(password) else { return nil }
        return TokensUser(id: NSUUID(), userName: username, password: password, tokens: [])
}

users
if let john = createNewUser("John@john.com", password: "some1Password", set: users){
    users.insert(john)
}
if let john2 = createNewUser("John@john.com", password: "another2Password", set: users){
    users.insert(john2)
}
if let shelby = createNewUser("Shelby@gmail.com", password: "another2Password", set: users){
    users.insert(shelby)
}
users

var user0 = users[users.startIndex]
user0.addToken()
user0.tokens
users.remove(user0)
users
users.insert(user0)
users










