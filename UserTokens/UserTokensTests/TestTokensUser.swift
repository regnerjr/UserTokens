import XCTest
@testable import UserTokens

class TestTokensUser: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCreationOneUser() {
        let newUser = TokensUser(userName: "John", password: "Password")
        XCTAssertEqual(newUser.userName, "John")
        XCTAssertEqual(newUser.password, "Password")
        XCTAssertEqual(newUser.tokens, [NSUUID]())
        XCTAssert( newUser.lastUpdated.timeIntervalSinceDate(newUser.dateCreated) < 1.0 )
    }

    func testTokens(){
        var newUser = TokensUser(userName: "John", password: "Password")
        XCTAssertEqual(newUser.tokens.count, 0)
        newUser.addToken()
        XCTAssertEqual(newUser.tokens.count, 1)
        XCTAssert(newUser.dateCreated.compare(newUser.lastUpdated) == .OrderedAscending )
    }

    func testTokenRemoval(){
        var newUser = TokensUser(userName: "John", password: "Password")

        newUser.addToken()
        let token = newUser.tokens[0]
        newUser.removeToken(token)
        XCTAssertEqual(newUser.tokens.count, 0) //back to zero, added one removed that one
        XCTAssert(newUser.dateCreated.compare(newUser.lastUpdated) == .OrderedAscending )

    }

    func testUserEquality(){
        let newUser = TokensUser(userName: "John", password: "Password")
        var otherUser = TokensUser(userName: "Pig", password: "babe")
        let same = newUser == otherUser
        XCTAssert(same == false) //two users should not be same
        otherUser = newUser
        let copiedSame = newUser == otherUser
        XCTAssert(copiedSame == true)
    }

    func testHashAndSetInsertion(){
        let newUser = TokensUser(userName: "John", password: "Password")
        var set = Set<TokensUser>()
        set.insert(newUser)
        //set should ensure only one user using hash conformance
        set.insert(newUser)
        XCTAssert(set.count == 1)
    }

}
