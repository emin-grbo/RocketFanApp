import XCTest
@testable import RocketFan

class CapsuleTests: XCTestCase {
    func test_CanBeDecoded_FromJSON() {
        guard let data = JSONLoader.load(.capsule) else {
            XCTFail("Missing file: Capsule.json")
            return
        }

        do {

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            _ = try decoder.decoded([Capsule].self, from: data)

        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
}
