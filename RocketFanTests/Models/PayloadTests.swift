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
            payload = payloads.first(where: { $0.id == "Thaicom 6" })

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
        let params = payload?.orbitParameters
        XCTAssertEqual(params?.referenceSystem, "geocentric")
        XCTAssertEqual(params?.regime, "geostationary")
        XCTAssertEqual(params?.eccentricity, 0.0003515)
        XCTAssertEqual(params?.inclinationDeg, 0.0745)
        XCTAssertEqual(params?.periodMin, 1436.111)
        XCTAssertEqual(params?.lifespanYears, 15)
        XCTAssertEqual(params?.meanMotion, 1.00270768)
        XCTAssertEqual(params?.raan, 114.4535)
        XCTAssertEqual(params?.semiMajorAxisKm, 42165.017)
        XCTAssertEqual(params?.periapsisKm, 35772.061)
        XCTAssertEqual(params?.apoapsisKm, 35801.703)
        XCTAssertEqual(params?.argOfPericenter, 336.7943)
        XCTAssertEqual(params?.meanAnomaly, 209.4034)
        XCTAssertNotNil(params?.epoch)
    }
}
