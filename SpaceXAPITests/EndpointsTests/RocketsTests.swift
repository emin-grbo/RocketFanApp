import XCTest
@testable import SpaceXAPI

class RocketsTests: XCTestCase {

    func test_Rockets_All_ReturnsPath() {
        let path = Rockets.all.path

        XCTAssertEqual(path, "/rockets")
    }

    func test_Rockets_One_ReturnsPath() {
        let identifier = "falcon9"

        let path = Rockets.one(identifier).path

        XCTAssertEqual(path, "/rockets/\(identifier)")
    }
}
