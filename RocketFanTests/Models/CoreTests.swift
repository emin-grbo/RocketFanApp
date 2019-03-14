import XCTest
@testable import RocketFan

class CoreTests: XCTestCase {
    var core: Core?

    override func setUp() {
        guard let data = JSONLoader.load(.core) else {
            XCTFail("Missing file: Core.json")
            return
        }

        do {

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let cores = try decoder.decoded([Core].self, from: data)
            core = cores.first

        } catch {
            XCTFail("Decoding failed: \(error)")
        }

    }

    func test_RequiredValuesCanBeDecoded_FromJSON() {
        XCTAssertNotNil(core)
    }

    func test_Block_CanBeDecoded_IfExists() {
        XCTAssertEqual(core?.block, 1)
    }

    func test_Details_CanBeDecoded_IfExists() {
        XCTAssertEqual(core?.details, "Stage Expended")
    }

    func test_LaunchDate_CanBeDecoded_IfExists() {
        let expectedDate = Date(timeIntervalSince1970: 1275677100)
        XCTAssertEqual(core?.originalLaunch, expectedDate)
    }
}
