import XCTest
@testable import RocketFan

class RoadsterTests: XCTestCase {
    var roadster: Roadster?

    override func setUp() {
        guard let data = JSONLoader.load(.roadster) else {
            XCTFail("Missing file: Roadster.json")
            return
        }

        do {

            let decoder = JSONDecoder(dateDecodingStrategy: .secondsSince1970)
            roadster = try decoder.decoded(Roadster.self, from: data)

        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    func test_RequiredValues_CanBeDecoded_FromJSON() {
        XCTAssertNotNil(roadster)
    }
}
