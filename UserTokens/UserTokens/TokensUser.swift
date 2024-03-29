import Foundation

class TokensUser: NSObject, NSCoding {
    var id: NSUUID
    var userName: NSString
    var password: NSString
    var tokens: [NSUUID]
    var dateCreated: NSDate
    var lastUpdated: NSDate
    init(userName: String, password: String, id: NSUUID = NSUUID(), tokens: [NSUUID] = [],lastUpdated: NSDate = NSDate()){
        self.userName = userName
        self.password = password
        self.id = id
        self.lastUpdated = lastUpdated
        self.tokens = tokens
        self.dateCreated = NSDate()
    }

    private init(userName: String, password: String, id: NSUUID = NSUUID(), tokens: [NSUUID] = [],lastUpdated: NSDate = NSDate(), created: NSDate = NSDate()){
        self.userName = userName
        self.password = password
        self.id = id
        self.lastUpdated = lastUpdated
        self.tokens = tokens
        self.dateCreated = created
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

    private enum CodingKeys : String {
        case id = "id"
        case userName = "userName"
        case password = "password"
        case dateCreated = "dateCreated"
        case lastUpdate = "lastUpdate"
        case tokens = "tokens"
    }

    //MARK: - NSCoding
    required init?(coder aDecoder: NSCoder) {
        if let identifier = aDecoder.decodeObjectForKey(CodingKeys.id.rawValue) as! NSUUID?,
            let name = aDecoder.decodeObjectForKey(CodingKeys.userName.rawValue) as! NSString?,
            let pass = aDecoder.decodeObjectForKey(CodingKeys.password.rawValue) as! NSString?,
            let created = aDecoder.decodeObjectForKey(CodingKeys.dateCreated.rawValue) as! NSDate?,
            let updated = aDecoder.decodeObjectForKey(CodingKeys.lastUpdate.rawValue) as! NSDate?,
            let savedtokens = aDecoder.decodeObjectForKey(CodingKeys.tokens.rawValue) as! Array<NSUUID>?
        {
            id = identifier
            userName = name as String
            password = pass as String
            tokens = savedtokens
            dateCreated = created
            lastUpdated = updated
            super.init()
        } else {
            id = NSUUID()
            userName = ""
            password = ""
            dateCreated = NSDate()
            lastUpdated = NSDate()
            tokens = [NSUUID]()
            super.init()
            return nil
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(id, forKey: CodingKeys.id.rawValue)
        aCoder.encodeObject(userName, forKey: CodingKeys.userName.rawValue)
        aCoder.encodeObject(password, forKey: CodingKeys.password.rawValue)
        aCoder.encodeObject(dateCreated, forKey: CodingKeys.dateCreated.rawValue)
        aCoder.encodeObject(lastUpdated, forKey: CodingKeys.lastUpdate.rawValue)
        aCoder.encodeObject(NSArray(array: tokens), forKey: CodingKeys.tokens.rawValue)
    }
}

func ==(lhs: TokensUser, rhs: TokensUser) -> Bool {
    return lhs.id == rhs.id && lhs.userName == rhs.userName
}

extension TokensUser: NSMutableCopying {
    func mutableCopyWithZone(zone: NSZone) -> AnyObject {
        return TokensUser(userName: userName as String, password: password as String, id: id, tokens: tokens, lastUpdated: NSDate(), created: dateCreated)
    }
}