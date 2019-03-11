import XCTest
@testable import SpaceXAPI

class HistoryTests: XCTestCase {

    func test_History_All_ReturnsPath() {
        let path = History.all.path

        XCTAssertEqual(path, "/history")
    }

    func test_History_One_ReturnsPath() {
        let identifier = "1"

        let path = History.one(identifier).path

        XCTAssertEqual(path, "/history/\(identifier)")
    }
}
