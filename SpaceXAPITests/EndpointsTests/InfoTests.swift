import XCTest
@testable import SpaceXAPI

class InfoTests: XCTestCase {

    func test_Info_Company_ReturnsPath() {
        let path = Info.company.path

        XCTAssertEqual(path, "/info")
    }

    func test_Api_Returns_Path() {
        let path = Info.api.path

        XCTAssertEqual(path, "")
    }
}
