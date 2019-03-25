import XCTest
@testable import RocketFan

class MissionTests: XCTestCase {
    var mission: Mission?
    var missions: [Mission]?

    override func setUp() {
        guard let data = JSONLoader.load(.mission) else {
            XCTFail("Missing file: Mission.json")
            return
        }

        do {

            missions = try data.decoded() as [Mission]
            mission = missions?.first

        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    func test_RequiredValues_CanBeDecoded_FromJSON() {
        XCTAssertNotNil(mission)
    }

    func test_LinksModel_CanBeDecoded() {
        let twitter = mission?.links.twitter
        XCTAssertEqual(twitter?.absoluteString, "https://twitter.com/IridiumBoss?lang=en")

        let wikipedia = mission?.links.wikipedia
        XCTAssertEqual(wikipedia?.absoluteString, "https://en.wikipedia.org/wiki/Iridium_satellite_constellation")

        let website = mission?.links.website
        XCTAssertEqual(website?.absoluteString, "https://www.iridiumnext.com/")
    }
}
