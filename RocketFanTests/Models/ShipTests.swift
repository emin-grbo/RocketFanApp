import XCTest
@testable import RocketFan

class ShipTests: XCTestCase {
    var ship: Ship?
    var ships: [Ship]?

    override func setUp() {
        guard let data = JSONLoader.load(.ship) else {
            XCTFail("Missing file: Ship.json")
            return
        }

        do {
            ships = try data.decoded() as [Ship]
            ship = ships?.first

        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    func test_RequiredValues_CanBeDecoded_FromJSON() {
        XCTAssertNotNil(ship)
    }

    func test_OptionalValues_CanBeDecoded_FromJSON_IfExist() {
        XCTAssertEqual(ship?.model, "Marmac 304")
        XCTAssertEqual(ship?.successfulLandings, 16)
        XCTAssertEqual(ship?.attemptedLandings, 19)

        let shipTwo = ships?[4]
        XCTAssertEqual(shipTwo?.imo, 9103295)
        XCTAssertEqual(shipTwo?.mmsi, 366943250)
        XCTAssertEqual(shipTwo?.abs, 1033239)
        XCTAssertEqual(shipTwo?.weightLbs, 1120000)
        XCTAssertEqual(shipTwo?.weightKg, 508023)
        XCTAssertEqual(shipTwo?.yearBuilt, 1995)
        XCTAssertEqual(shipTwo?.speedKn, 0)
        XCTAssertEqual(shipTwo?.status, "Moored")
        XCTAssertEqual(shipTwo?.location.latitude, 29.95037)
        XCTAssertEqual(shipTwo?.location.longitude, -90.05646)

        //swiftlint:disable line_length
        XCTAssertEqual(shipTwo?.url?.absoluteString, "https://www.marinetraffic.com/en/ais/details/ships/shipid:430027/vessel:HAWK")
        XCTAssertEqual(shipTwo?.imageUrl?.absoluteString, "https://i.imgur.com/hGWWupT.jpg")

        let shipTHree = ships?[6]
        XCTAssertEqual(shipTHree?.courseDeg, 79)
    }
}
