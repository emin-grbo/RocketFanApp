import XCTest

@testable import RocketFan

class LaunchCellViewModelTests: XCTestCase {
    var sut: LaunchCellViewModel?
    var launch: Launch?
    var dateFormatter: DateFormatter?

    override func setUp() {
        dateFormatter = getDateFormatter()
        launch = getLaunch()

        sut = LaunchCellViewModel(with: launch!, dateFormatter!)
    }

    override func tearDown() {
        sut = nil
        launch = nil
    }

    func test_GivenLaunch_ReturnsMissionName() {
        XCTAssertEqual(sut?.missionName, launch?.missionName)
    }

    func test_GivenLaunch_ReturnsFormattedLaunchDate() {
        XCTAssertEqual(sut?.launchDate, "01 Sep 2020, 00:00:00")
    }

    func test_GivenLaunch_ReturnsSiteShortName() {
        XCTAssertEqual(sut?.siteShortName, launch?.site.shortName)
    }

    func test_GivenLaunch_ReturnsRocketName() {
        XCTAssertEqual(sut?.rocketName, launch?.rocket.name)
    }

    func test_GivenLaunch_ReturnsSmallMissionOatchURL() {
        XCTAssertEqual(sut?.missingPatchSmallURL, launch?.links.missingPatchSmall)
    }
    
    func test_GivenLaunchWithNoDate_ReturnsTBC() {
        let launch = getLaunchWithNoDate()

        sut = LaunchCellViewModel(with: launch, dateFormatter!)

        XCTAssertEqual(sut?.launchDate, "TBC")
    }
}

extension LaunchCellViewModelTests {
    private func getLaunch() -> Launch {
        return Launch(launchDate: launchDate()!,
                      missionName: "GPS SV05",
                      rocket: rocket(),
                      site: launchSite())
    }

    private func getLaunchWithNoDate() -> Launch {
        return Launch(missionName: "GPS SV05",
                      rocket: rocket(),
                      site: launchSite())
    }

    func launchDate() -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]

        return formatter.date(from: "2020-09-01T00:00:00.000Z")
    }

    private func getDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()

        formatter.locale = Locale(identifier: "en_GB")
        formatter.timeZone = TimeZone(identifier: "GMT")
        formatter.setPrecision(.hour)

        return formatter
    }

    private func launchSite() -> Launch.Site {
        return Launch.Site(shortName: "CCAFS SLC 40")
    }

    private func rocket() -> Launch.Rocket {
        return Launch.Rocket(name: "Falcon 9")
    }
}
