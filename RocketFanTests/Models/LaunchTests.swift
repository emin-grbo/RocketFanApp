import XCTest
@testable import RocketFan

class LaunchTests: XCTestCase {
    var launch: Launch?
    var launches: [Launch]?

    override func setUp() {
        guard let data = JSONLoader.load(.launches) else {
            XCTFail("Missing file: launches.json")
            return
        }

        do {

            let decoder = JSONDecoder(dateDecodingStrategy: .secondsSince1970)
            launches = try decoder.decoded([Launch].self, from: data)
            launch = launches?.first(where: { $0.flightNumber == 3 })

        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    func test_RequiredValues_CanBeDecoded_FromJSON() {
        XCTAssertNotNil(launch)
    }

    func test_Details_CanBeDecoded_FromJSON() {
        let details = "Residual stage 1 thrust led to collision between stage 1 and stage 2"
        XCTAssertEqual(launch?.details, details)
    }

    func test_LaunchDate_CanBeDecoded_FromJSON() {
        let launchDate = Date(timeIntervalSince1970: 1217648040)
        XCTAssertEqual(launch?.launchDate, launchDate)
    }

    func test_FailureDetails_CanBeDecoded_FromJSON() {
        let failureDetails = Launch.FailureDetails(
            altitude: 35,
            reason: "residual stage-1 thrust led to collision between stage 1 and stage 2",
            time: 140
        )
        XCTAssertEqual(launch?.failureDetails, failureDetails)
    }

    func test_Timeline_CanBeDecoded_FromJSON() {
        let timeline = ["webcast_liftoff": 14]
        XCTAssertEqual(launch?.timeline, timeline)
    }

    func test_StaticFireDate_CanBeDecoded_FromJSON() {
        launch = launches?.first(where: { $0.flightNumber == 1 })

        let staticFireDate = Date(timeIntervalSince1970: 1142553600)
        XCTAssertEqual(launch?.staticFireDate, staticFireDate)
    }

    func test_MissionID_CanBeDecoded_FromJSON() {
        launch = launches?.first(where: { $0.flightNumber == 6 })

        let missionId = ["EE86F74"]
        XCTAssertEqual(launch?.missionId, missionId)
    }

    func test_Ships_CanBeDecoded_FromJSON() {
        launch = launches?.first(where: { $0.flightNumber == 7 })

        let ships = ["AMERICANCHAMPION"]
        XCTAssertEqual(launch?.ships, ships)
    }

    func test_FlightClub_CanBeDecoded_FromJSON() {
        launch = launches?.first(where: { $0.flightNumber == 25 })

        let flightClub = URL(string: "https://www.flightclub.io/results/?code=OG22")!
        XCTAssertEqual(launch?.flightClub, flightClub)
    }

    func test_CanCompare_UsingComparable() {
        let firstLaunch = (launches?.first(where: { $0.flightNumber == 1 })!)!
        let secondLaunch = (launches?.first(where: { $0.flightNumber == 25 })!)!
        let unSortedLaunches = [secondLaunch, firstLaunch]

        let sorted = unSortedLaunches.sorted(by: <)

        XCTAssertEqual(sorted.first, firstLaunch)
    }
}
