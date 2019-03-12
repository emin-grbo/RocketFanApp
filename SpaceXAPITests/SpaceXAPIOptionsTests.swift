import XCTest
import SpaceXAPI

class SpaceXAPIOptionsTests: XCTestCase {
    func test_SpaceXAPIOptions_ShouldHaveDefaultLimit() {
        let options = SpaceXAPI.Options()

        let queryItems = options.queryItems

        XCTAssertNotNil(queryItems.first(where: { $0.name == "limit" }), "\(queryItems) does not contain limit query")
    }

    func test_SpaceXAPIOptions_ShouldHaveDefaultOffset() {
        let options = SpaceXAPI.Options()

        let queryItems = options.queryItems

        XCTAssertNotNil(queryItems.first(where: { $0.name == "offset" }), "\(queryItems) does not contain offset query")
    }

    func test_SpaceXAPIOptions_WithFilterOptions_CreatesQueryItems() {
        let option = "flight_number"
        let filterOptions = [option]
        let options = SpaceXAPI.Options(filterOptions: filterOptions)

        let queryItems = options.queryItems

        let expectedItem = URLQueryItem(name: "filter", value: option)
        XCTAssertTrue(queryItems.contains(expectedItem), "\(queryItems) did not contain \(expectedItem)")
    }

    func test_SpaceXAPIOptions_ShouldHaveSpecifiedLimit() {
        let limit = 1
        let options = SpaceXAPI.Options(limit: limit)

        let queryItems = options.queryItems

        let expectedItem = URLQueryItem(name: "limit", value: String(limit))
        XCTAssertTrue(queryItems.contains(expectedItem), "\(queryItems) does not contain \(expectedItem)")
    }

    func test_SpaceXAPIOptions_ShouldHaveSpecifiedOffset() {
        let offset = 1
        let options = SpaceXAPI.Options(offset: offset)

        let queryItems = options.queryItems

        let expectedItem = URLQueryItem(name: "offset", value: String(offset))
        XCTAssertTrue(queryItems.contains(expectedItem), "\(queryItems) does not contain \(expectedItem)")
    }
}
