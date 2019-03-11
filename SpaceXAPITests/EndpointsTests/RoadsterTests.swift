import XCTest
@testable import SpaceXAPI

class RoadsterTests: XCTestCase {

    func test_Roadster_Location_ReturnsPath() {
        let path = Roadster.location.path

        XCTAssertEqual(path, "/roadster")
    }
}
