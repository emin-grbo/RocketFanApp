import XCTest
@testable import RocketFan

class ApiInfoTests: XCTestCase {
    var apiInfo: ApiInfo?

    override func setUp() {
        guard let data = JSONLoader.load(.apiinfo) else {
            XCTFail("Missing file: apiinfo.json")
            return
        }

        do {

            apiInfo = try data.decoded() as ApiInfo

        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    func test_RequiredValues_CanBeDecoded_FromJSON() {
        XCTAssertNotNil(apiInfo)
    }
}
