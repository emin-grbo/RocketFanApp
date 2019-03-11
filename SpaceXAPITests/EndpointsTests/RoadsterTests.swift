import XCTest
@testable import SpaceXAPI

class RoadsterTests: XCTestCase {

    func test_Roadster_Current_ReturnsPath() {
        let path = Roadster.location.path

        XCTAssertEqual(path, "/roadster")
    }
}
