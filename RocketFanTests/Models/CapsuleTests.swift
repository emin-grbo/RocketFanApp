import XCTest
@testable import RocketFan

class CapsuleTests: XCTestCase {
    func test_JSON_Mapping() {
        guard  let data = JSONLoader.load(.capsule) else {
            XCTFail("Missing file: Capsule.json")
            return
        }
        
    }
}
