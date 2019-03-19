import XCTest
@testable import RocketFan

class PayloadTests: XCTestCase {
    private var payload: Payload?

    override func setUp() {
        guard let data = JSONLoader.load(.payload) else {
            XCTFail("Missing file: Payload.json")
            return
        }

        do {

            let payloads = try data.decoded() as [Payload]
            payload = payloads[15]

        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    func test_RequiredValues_CanBeDecoded_FromJSON() {
        XCTAssertNotNil(payload)
    }

    func test_OptionalValues_CanBeDecoded_FromJSON_IfExist() {
        XCTAssertEqual(payload?.nationality, "Thailand")
        XCTAssertEqual(payload?.manufacturer, "Orbital ATK")
        XCTAssertEqual(payload?.mass?.metric, 3325)
        XCTAssertEqual(payload?.mass?.imperial, 7330)
    }

    func test_OrbitParams_CanBeDecoded_FromJSON_IfExist() {
        let params = payload?.orbitParams
        XCTAssertEqual(params?.referenceSystem, "geocentric")
        XCTAssertEqual(params?.regime, "geostationary")
        XCTAssertEqual(params?.eccentricity, 0.0001895)
        XCTAssertEqual(params?.inclinationDeg, 0.053)
        XCTAssertEqual(params?.periodMin, 1436.126)
        XCTAssertEqual(params?.lifespanYears, 15)
        XCTAssertEqual(params?.meanMotion, 1.00269716)
        XCTAssertEqual(params?.raan, 128.9429)
        XCTAssertEqual(params?.semiMajorAxisKm, 42165.311)
        XCTAssertEqual(params?.periapsisKm, 35779.186)
        XCTAssertEqual(params?.apoapsisKm, 35795.167)
        XCTAssertEqual(params?.argOfPericenter, 284.584)
        XCTAssertEqual(params?.meanAnomaly, 151.6653)
    }
}
