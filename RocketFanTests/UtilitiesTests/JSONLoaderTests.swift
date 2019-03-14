import XCTest
@testable import RocketFan

class JSONLoaderTests: XCTestCase {

    func test_GivenFile_ReturnsData() {
        let data = JSONLoader.load(.capsule)

        XCTAssertNotNil(data)
    }
}
