import XCTest
@testable import RocketFan

class SearchEngineTests: XCTestCase {
    private var sut: SearchEngine?

    override func setUp() {
        guard let allLaunches = loadLaunchs() else {
            XCTFail("Couldn't load test data")
            return
        }

        sut = SearchEngine(with: allLaunches)
    }

    override func tearDown() {
        sut = nil
    }

    func test_GivenReferenceDate_ReturnsPastLaunches() {
        let date = referenceDate()
        let launches = sut?.launches(before: date)

        XCTAssertTrue(all(launches!, areBefore: date), "All launches must be before referenceDate")
    }

    func test_GivenReferenceDate_ReturnsFutureLaunches() {
        let date = referenceDate()
        let upcomingLaunches = sut?.launches(after: date)

        XCTAssertTrue(all(upcomingLaunches!, areAfter: date), "All launches must be after referenceDate")
    }

    func test_GivenEmptySearchTerm_ReturnsEmptyResult() {
        let launches = sut?.launchesWhere(missionNameContains: "")

        XCTAssertTrue(launches!.isEmpty)
    }

    func test_GivenIncorrectSearchTerm_ReturnsEmptyResults() {
        let launches = sut?.launchesWhere(missionNameContains: "99999")

        XCTAssertTrue(launches!.isEmpty, "Should be empty")
    }

    func test_GivenCompleteSearchTerm_ReturnsOneLaunch() {
        let launches = sut?.launchesWhere(missionNameContains: "FalconSat")

        XCTAssertTrue(launches!.count == 1, "Should have exactly one result")
    }

    func test_GivenPartialSearchTerm_ReturnsManyLaunches() {
        let launches = sut?.launchesWhere(missionNameContains: "Sat")

        XCTAssertTrue(launches!.count > 1, "Should not be empty")
    }

    func test_GivenValidSearchTermWithSpace_ReturnsNonEmptyResult() {
        let launches = sut?.launchesWhere(missionNameContains: "Falcon 9")

        XCTAssertFalse(launches!.isEmpty, "Should not be empty")
    }

    func test_GivenValidSearchTermWithLeadingWithSpace_ReturnsNonEmptyResult() {
        let launches = sut?.launchesWhere(missionNameContains: "Falcon ")

        XCTAssertFalse(launches!.isEmpty, "Should not be empty")
    }

    func test_GivenUpperCaseSearchTerm_ReturnsNonEmptyResult() {
        let launches = sut?.launchesWhere(missionNameContains: "FALCON 9")

        XCTAssertFalse(launches!.isEmpty, "Should not be empty")
    }
}

// MARK: - Test Helpers
extension SearchEngineTests {
    private func loadLaunchs() -> [Launch]? {
        let json = JSONLoader.load(.launches)!
        let decoder = JSONDecoder(dateDecodingStrategy: .secondsSince1970)
        return try? decoder.decoded([Launch].self, from: json)
    }

    private func all(_ launaches: [Launch], areBefore date: Date) -> Bool {
        let todaysDate = Date()

        for launch in launaches {
            guard let launchDate = launch.launchDate else { return false }

            if launchDate >= todaysDate {
                return false
            }
        }

        return true
    }

    private func all(_ launaches: [Launch], areAfter date: Date) -> Bool {
        let todaysDate = Date()

        for launch in launaches {
            guard let launchDate = launch.launchDate else { continue }

            if launchDate > todaysDate {
                return true
            }
        }

        return false
    }

    private func referenceDate() -> Date {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFractionalSeconds]

        return formatter.date(from: "2019-05-25T00:00:00.000Z")!
    }
}
