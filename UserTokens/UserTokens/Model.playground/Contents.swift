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

class TokensUser: NSObject {
    let id: NSUUID
    let userName: String
    let password: String
    var tokens : [NSUUID]
    let dateCreated = NSDate()
    var lastUpdated: NSDate
    init(userName: String, password: String, id: NSUUID = NSUUID(), tokens: [NSUUID] = [],lastUpdated: NSDate = NSDate()){
        self.userName = userName
        self.password = password
        self.id = id
        self.lastUpdated = lastUpdated
        self.tokens = tokens
    }
    func addToken(newToken: NSUUID = NSUUID()){
        tokens.append(newToken)
    }
    func removeToken(token: NSUUID) {
        tokens = tokens.filter{$0 != token}
    }
    override var hashValue: Int {
        return "\(id) \(userName)".hashValue
    }
}

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
    return TokensUser(userName: username, password: password)
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


func userNameIsUniqueIn(set: NSArray, username: String) -> Bool {
    if set.count == 0 {
        return true // is unique
    }
    let matches = set.indexesOfObjectsPassingTest({
    obj, index, stop in
        let user = obj as! TokensUser
        user.userName
        username
        if user.userName == username {
            return true
        }
        return false
    })
    return matches.count == 0
}



var arr = NSMutableArray()

let user = TokensUser(userName: "john@john.com", password: "asdfasdf123")

arr.addObject(user)

userNameIsUniqueIn(arr, username: "john@john.co")










































