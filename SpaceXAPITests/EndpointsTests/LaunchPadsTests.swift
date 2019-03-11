import XCTest
@testable import SpaceXAPI

class LaunchPadsTests: XCTestCase {

    func test_LaunchPads_All_ReturnsPath() {
        let path = LaunchPads.all.path

        XCTAssertEqual(path, "/launchpads")
    }

    func test_LaunchPads_One_ReturnsPath() {
        let identifier = "vafb_slc_4w"

        let path = LaunchPads.one(identifier).path

        XCTAssertEqual(path, "/launchpads/\(identifier)")
    }
}
