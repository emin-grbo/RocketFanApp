import XCTest
@testable import SpaceXAPI

class LaunchesTests: XCTestCase {

    func test_Launches_All_ReturnsPath() {
        let path = Launches.all.path

        XCTAssertEqual(path, "/launches")
    }

    func test_Launches_One_ReturnsPath() {
        let identifier = "65"

        let path = Launches.one(identifier).path

        XCTAssertEqual(path, "/launches/\(identifier)")
    }

    func test_Launches_Path_ReturnsPath() {
        let path = Launches.past.path

        XCTAssertEqual(path, "/launches/past")
    }

    func test_Launches_Upcoming_ReturnsPath() {
        let path = Launches.upcoming.path

        XCTAssertEqual(path, "/launches/upcoming")
    }

    func test_Launches_Latest_ReturnsPath() {
        let path = Launches.latest.path

        XCTAssertEqual(path, "/launches/latest")
    }

    func test_Launches_Next_ReturnsPath() {
        let path = Launches.next.path

        XCTAssertEqual(path, "/launches/next")
    }
}
