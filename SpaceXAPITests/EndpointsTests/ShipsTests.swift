import XCTest
@testable import SpaceXAPI

class ShipsTests: XCTestCase {

    func test_Ships_All_ReturnsPath() {
        let path = Ships.all.path

        XCTAssertEqual(path, "/ships")
    }

    func test_Ships_One_ReturnsPath() {
        let identifier = "MRSTEVEN"

        let path = Ships.one(identifier).path

        XCTAssertEqual(path, "/ships/\(identifier)")
    }
}
