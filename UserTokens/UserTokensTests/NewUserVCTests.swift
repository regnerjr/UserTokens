import XCTest
@testable import UserTokens

class NewUserVCTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testUniqueUserNames() {
        let userOne = TokensUser(userName: "john@john.com", password: "asdfasdf123")
        let array = NSMutableArray()
        array.addObject(userOne)

        let unique = userNameIsUniqueIn(array, username: "john@john.com")
        XCTAssertEqual(unique, false)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
