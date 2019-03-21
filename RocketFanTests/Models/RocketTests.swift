import XCTest
@testable import RocketFan

class RocketTests: XCTestCase {
    private var rocket: Rocket?

    override func setUp() {
        guard let data = JSONLoader.load(.rocket) else {
            XCTFail("Missing file: Rocket.json")
            return
        }

        do {

            let rockets = try data.decoded() as [Rocket]
            rocket = rockets.first(where: { $0.id == "falcon9" })

        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    func test_RequiredValues_CanBeDecoded_FromJSON() {
        XCTAssertNotNil(rocket)
    }

    func test_FirstStageValues_CanBeDecoded_FromJSON_IfExist() {
        XCTAssertEqual(rocket?.firstStage.burnTimeSec, 162)
        XCTAssertEqual(rocket?.firstStage.thrustSeaLevel?.metric, 7607.0)
        XCTAssertEqual(rocket?.firstStage.thrustSeaLevel?.imperial, 1710000.0)
        XCTAssertEqual(rocket?.firstStage.thrustVacuum?.imperial, 1849500.0)
        XCTAssertEqual(rocket?.firstStage.thrustVacuum?.metric, 8227.0)
    }

    func test_SecondStageValues_CanBeDecoded_FromJSON_IfExist() {
        XCTAssertEqual(rocket?.secondStage.thrust?.imperial, 210000.0)
        XCTAssertEqual(rocket?.secondStage.thrust?.metric, 934.0)
        XCTAssertNotNil(rocket?.secondStage.payloads)
        XCTAssertNotNil(rocket?.secondStage.payloads?.compositeFairing)
    }

    func test_EngineValues_CanBeDecoded_FromJSON_IfExist() {
        XCTAssertEqual(rocket?.engine.losMax, 2)
        XCTAssertEqual(rocket?.engine.layout, "octaweb")
    }

    func test_LandingLegsValues_CanBeDecoded_FromJSON_IfExist() {
        XCTAssertEqual(rocket?.landingLegs.number, 4)
        XCTAssertEqual(rocket?.landingLegs.material, "carbon fiber")
    }
}
