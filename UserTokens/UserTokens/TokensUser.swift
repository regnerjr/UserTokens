import Foundation

class TokensUser: NSObject {
    let id: NSUUID
    var userName: String
    var password: String
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
        lastUpdated = NSDate()
    }
     func removeToken(token: NSUUID) {
        tokens = tokens.filter{$0 != token}
        lastUpdated = NSDate()
    }
    override var hashValue: Int {
        return "\(userName)".hashValue
    }
}

func ==(lhs: TokensUser, rhs: TokensUser) -> Bool {
    return lhs.id == rhs.id && lhs.userName == rhs.userName
}