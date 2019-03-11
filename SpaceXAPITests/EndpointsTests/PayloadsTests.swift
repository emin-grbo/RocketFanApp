import XCTest
@testable import SpaceXAPI

class PayloadsTests: XCTestCase {

    func test_Payloads_All_ReturnsPath() {
        let path = Payloads.all.path

        XCTAssertEqual(path, "/payloads")
    }

    func test_Payloads_One_ReturnsPath() {
        let identifier = "Telkom-4"

        let path = Payloads.one(identifier).path

        XCTAssertEqual(path, "/payloads/\(identifier)")
    }
}
