import XCTest
@testable import RocketFan

class LandingPadTests: XCTestCase {
    var landingPad: LandingPad?

    override func setUp() {
        guard let data = JSONLoader.load(.landingPad) else {
            XCTFail("Missing file: LandingPad.json")
            return
        }

        do {

            let decoder = JSONDecoder(dateDecodingStrategy: .secondsSince1970)
            let landingPads = try decoder.decoded([LandingPad].self, from: data)
            landingPad = landingPads.first(where: { $0.id == "LZ-1" })

        } catch {
            XCTFail("Decoding failed: \(error)")
        }

    }

    func test_RequiredValues_CanBeDecoded_FromJSON() {
        XCTAssertNotNil(landingPad)
    }
}
