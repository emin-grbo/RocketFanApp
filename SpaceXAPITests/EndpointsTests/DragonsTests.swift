import XCTest
@testable import SpaceXAPI

class DragonsTests: XCTestCase {

    func test_Dragons_All_ReturnsPath() {
        let path = Dragons.all.path

        XCTAssertEqual(path, "/dragons")
    }

    func test_Dragons_One_ReturnsPath() {
        let identifier = "dragon1"

        let path = Dragons.one(identifier).path

        XCTAssertEqual(path, "/dragons/\(identifier)")
    }
}
