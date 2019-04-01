import XCTest
@testable import RocketFan

class ShipTests: XCTestCase {
    var ship: Ship?

    override func setUp() {
        ship = try? jsonData.decoded() as Ship
    }

    func test_CanBeDecoded_FromProductionJSON() {
        guard let data = JSONLoader.load(.ship) else {
            XCTFail("Missing file: Ship.json")
            return
        }

        do {
            let ships = try data.decoded() as [Ship]
            ship = ships.first
        } catch {
            XCTFail("Decoding failed: \(error)")
        }

        XCTAssertNotNil(ship)
    }

    func test_CanDecodeRequiredParameters_FromFixedJSON() {
        do {
            ship = try jsonData.decoded()
        } catch {
            XCTFail("Decoding failed: \(error)")
        }

        XCTAssertEqual(ship?.homePort, "Port of Los Angeles")
        XCTAssertEqual(ship?.id, "FOO")
        XCTAssertEqual(ship?.isActive, true)
        XCTAssertEqual(ship?.name, "Foo Bar")
        XCTAssertEqual(ship?.roles, ["ASDS Barge"])
        XCTAssertEqual(ship?.type, "Barge")
        XCTAssertEqual(ship?.weight?.imperial, 5.0)
        XCTAssertEqual(ship?.weight?.metric, 6.0)
        XCTAssertEqual(ship?.yearBuilt, 2000)

        let missions = [MissionFragment(name: "COTS 1", flight: 7)]
        XCTAssertEqual(ship?.missions, missions)
    }

    func test_CanDecodeOptionalParameters_FromFixedJSON() {
        do {
            ship = try jsonData.decoded()
        } catch {
            XCTFail("Decoding failed: \(error)")
        }

        XCTAssertEqual(ship?.course, 90)
        XCTAssertEqual(ship?.identifiers?.abs, 3)
        XCTAssertEqual(ship?.identifiers?.imo, 1)
        XCTAssertEqual(ship?.identifiers?.mmsi, 2)
        XCTAssertEqual(ship?.imageUrl?.absoluteString, "https://i.imgur.com/woCxpkj.jpg")
        XCTAssertEqual(ship?.landing?.attempts, 12)
        XCTAssertEqual(ship?.landing?.successes, 10)
        XCTAssertEqual(ship?.location?.latitude, 30.18666)
        XCTAssertEqual(ship?.location?.longitude, -91.01443)
        XCTAssertEqual(ship?.model, "Qux")
        XCTAssertEqual(ship?.speed, 5.0)
        XCTAssertEqual(ship?.status, "Underway Using Engine")
        XCTAssertEqual(ship?.url?.absoluteString, "https://google.com")
        XCTAssertEqual(ship?.weight?.imperial, 5.0)
        XCTAssertEqual(ship?.weight?.metric, 6.0)
        XCTAssertEqual(ship?.yearBuilt, 2000)
    }
}

extension ShipTests {
    var jsonData: Data {
        return """
        {
          "ship_id": "FOO",
          "ship_name": "Foo Bar",
          "ship_model": "Qux",
          "ship_type": "Barge",
          "roles": [
            "ASDS Barge"
          ],
          "active": true,
          "imo": 1,
          "mmsi": 2,
          "abs": 3,
          "class": 4,
          "weight_lbs": 5,
          "weight_kg": 6,
          "year_built": 2000,
          "home_port": "Port of Los Angeles",
          "status": "Underway Using Engine",
          "speed_kn": 5,
          "course_deg": 90,
          "position": {
            "latitude": 30.18666,
            "longitude": -91.01443
          },
          "successful_landings": 10,
          "attempted_landings": 12,
          "missions": [
            {
              "name": "COTS 1",
              "flight": 7
            }
          ],
          "url": "https://google.com",
          "image": "https://i.imgur.com/woCxpkj.jpg"
        }
        """.data(using: .utf8)!
    }
}
