import XCTest
@testable import RocketFan

class DragonTests: XCTestCase {
    func test_CanBeDecoded_FromJSON() {
        guard let data = JSONLoader.load(.dragon) else {
            XCTFail("Missing file: Dragon.json")
            return
        }

        do {

            let decoder = JSONDecoder(dateDecodingStrategy: .secondsSince1970)
            _ = try decoder.decoded([Dragon].self, from: data)

        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
}
