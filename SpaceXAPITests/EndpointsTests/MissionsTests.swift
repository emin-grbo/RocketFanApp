import XCTest
@testable import SpaceXAPI

class MissionsTests: XCTestCase {

    func test_Missions_All_ReturnsPath() {
        let path = Missions.all.path

        XCTAssertEqual(path, "/missions")
    }

    func test_Missions_One_ReturnsPath() {
        let identifier = "F3364BF"

        let path = Missions.one(identifier).path

        XCTAssertEqual(path, "/missions/\(identifier)")
    }
}
