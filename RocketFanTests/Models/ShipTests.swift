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

        let shipTwo = ships?[4]
        XCTAssertEqual(shipTwo?.yearBuilt, 1995)
        XCTAssertEqual(shipTwo?.speedKn, 0)
        XCTAssertEqual(shipTwo?.status, "Moored")

        //swiftlint:disable line_length
        XCTAssertEqual(shipTwo?.url?.absoluteString, "https://www.marinetraffic.com/en/ais/details/ships/shipid:430027/vessel:HAWK")
        XCTAssertEqual(shipTwo?.imageUrl?.absoluteString, "https://i.imgur.com/hGWWupT.jpg")

        let shipThree = ships?[6]
        XCTAssertEqual(shipThree?.courseDeg, 79)
    }

    func test_Landings_CanBeDecoded() {
        XCTAssertEqual(ship?.landings?.successful, 16)
        XCTAssertEqual(ship?.landings?.attempted, 19)
    }

    func test_Location_CanBeDecoded() {
        let ship = ships?[4]

        XCTAssertEqual(ship?.location?.latitude, 29.95037)
        XCTAssertEqual(ship?.location?.longitude, -90.05646)
    }

    func test_Weight_CanBeDecoded() {
        let ship = ships?[4]

        XCTAssertEqual(ship?.weight?.lbs, 1120000)
        XCTAssertEqual(ship?.weight?.kg, 508023)
    }

    func test_Identifiers_CanBeDecoded() {
        let ship = ships?[4]

        XCTAssertEqual(ship?.identifiers?.imo, 9103295)
        XCTAssertEqual(ship?.identifiers?.mmsi, 366943250)
        XCTAssertEqual(ship?.identifiers?.abs, 1033239)
    }
}
