import XCTest
@testable import RocketFan

class CompanyTests: XCTestCase {
    var company: Company?

    override func setUp() {
        guard let data = JSONLoader.load(.company) else {
            XCTFail("Missing file: company.json")
            return
        }

        do {

            company = try data.decoded() as Company

        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    func test_RequiredValues_CanBeDecoded_FromJSON() {
        XCTAssertNotNil(company)
    }
}
