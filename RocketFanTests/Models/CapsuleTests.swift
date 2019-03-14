import XCTest
@testable import RocketFan

class CapsuleTests: XCTestCase {
    var capsule: Capsule?

    override func setUp() {
        guard let data = JSONLoader.load(.capsule) else {
            XCTFail("Missing file: Capsule.json")
            return
        }

        do {

            let decoder = JSONDecoder(dateDecodingStrategy: .secondsSince1970)
            let capsules = try decoder.decoded([Capsule].self, from: data)
            capsule = capsules.first

        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    func test_RequiredValues_CanBeDecoded_FromJSON() {
        XCTAssertNotNil(capsule)
    }

    func test_OptionalValues_CanBeDecoded_FromJSON_IfExist() {
        XCTAssertEqual(capsule?.details, "Reentered after three weeks in orbit")

        let expectedDate = Date(timeIntervalSince1970: 1291822980)
        XCTAssertEqual(capsule?.originalLaunch, expectedDate)
    }
}
