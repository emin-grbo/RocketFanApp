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
        let shipWithModel = ships?[11]
        XCTAssertEqual(shipWithModel?.model, "Marmac 300")

        let shipTwo = ships?[4]
        XCTAssertEqual(shipTwo?.yearBuilt, 1974)
        XCTAssertEqual(shipTwo?.speed?.kn, 0)
        XCTAssertEqual(shipTwo?.status, "Stopped")

        //swiftlint:disable line_length
        XCTAssertEqual(shipTwo?.url?.absoluteString, "https://www.marinetraffic.com/en/ais/details/ships/shipid:428415/vessel:BETTY%20R%20GAMBARELLA")
        XCTAssertEqual(shipTwo?.imageUrl?.absoluteString, "https://i.imgur.com/ngYgFnn.jpg")

        let shipThree = ships?[5]
        XCTAssertEqual(shipThree?.courseDeg, 263)
    }

    func test_Landings_CanBeDecoded() {
        let shipWithLandings = ships?[11]

        XCTAssertEqual(shipWithLandings?.landings?.successful, 0)
        XCTAssertEqual(shipWithLandings?.landings?.attempted, 2)
    }

    func test_Location_CanBeDecoded() {
        let ship = ships?[4]

        XCTAssertEqual(ship?.location?.latitude, 33.77139)
        XCTAssertEqual(ship?.location?.longitude, -118.2123)
    }

    func test_Weight_CanBeDecoded() {
        let ship = ships?[4]

        XCTAssertEqual(ship?.weight?.imperial, 446000)
        XCTAssertEqual(ship?.weight?.metric, 202302)
    }

    func test_Identifiers_CanBeDecoded() {
        let ship = ships?[4]

        XCTAssertEqual(ship?.identifiers?.imo, 7517478)
        XCTAssertEqual(ship?.identifiers?.mmsi, 368000890)
        XCTAssertEqual(ship?.identifiers?.abs, 562590)
    }
}
