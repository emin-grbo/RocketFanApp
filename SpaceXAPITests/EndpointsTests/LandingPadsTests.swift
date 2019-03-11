import XCTest
@testable import SpaceXAPI

class LandingPadsTests: XCTestCase {

    func test_LandingPards_ReturnsPath() {
        let path = LandingPads.all.path

        XCTAssertEqual(path, "/landpads")
    }

    func test_LandingPads_One_ReturnsPath() {
        let identifier = "LZ-4"

        let path = LandingPads.one(identifier).path

        XCTAssertEqual(path, "/landpads/\(identifier)")
    }
}
