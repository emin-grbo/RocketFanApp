import XCTest
@testable import SpaceXAPI

class CapsulesTests: XCTestCase {

    func test_Capsules_All_ReturnsPath() {
        let path = Capsules.all.path

        XCTAssertEqual(path, "/capsules")
    }

    func test_Capsules_One_ReturnsPath() {
        let identifier = "C223"

        let path = Capsules.one(identifier).path

        XCTAssertEqual(path, "/capsules/\(identifier)")
    }

    func test_Capsules_Upcoming_ReturnsPath() {
        let path = Capsules.upcoming.path

        XCTAssertEqual(path, "/capsules/upcoming")
    }

    func test_Capsules_Past_ReturnsPath() {
        let path = Capsules.past.path

        XCTAssertEqual(path, "/capsules/past")
    }
}
