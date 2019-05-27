import XCTest

@testable
import RocketFan

class LaunchDetailsViewModelTests: XCTestCase {
    var launch: Launch!
    var viewModel: LaunchDetailsViewModel!
    var launchDate: Date!

    override func setUp() {
        super.setUp()
        launch = loadLaunch()
        viewModel = LaunchDetailsViewModel(launch: launch)
        launchDate = ISO8601DateFormatter().date(from: "2019-05-24T07:47:13+0000")!
    }

    func test_Provides_LaunchTitle() {
        XCTAssertEqual(viewModel.title, launch.missionName)
    }

    func test_Provides_FlightNumber() {
        XCTAssertEqual(viewModel.flightNumber, "Flight #1")
    }

    func test_Provides_Description() {
        XCTAssertEqual(viewModel.description, launch.details)
    }

    func test_Provides_Date() {
        launch = Launch(launchDate: launchDate)
        viewModel = LaunchDetailsViewModel(launch: launch)

        let expected = dateFormatter(precision: .hour).string(from: launchDate)
        XCTAssertEqual(viewModel.date, expected)
    }

    func test_Provides_TentativeDate() {
        launch = Launch(isTentative: true, launchDate: launchDate, tentativeMaxPrecision: "month")
        viewModel = LaunchDetailsViewModel(launch: launch)

        let expected = dateFormatter(precision: .month).string(from: launchDate)
        XCTAssertEqual(viewModel.date, expected)
    }

    // MARK: - Test Helpers

    private func loadLaunch() -> Launch? {
        let json = JSONLoader.load(.launches)!
        let decoder = JSONDecoder(dateDecodingStrategy: .secondsSince1970)
        let launches = try? decoder.decoded([Launch].self, from: json)
        return launches?.first(where: { $0.flightNumber == 1 })
    }

    private func dateFormatter(precision: DateFormatter.Precision) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.setPrecision(precision)

        return formatter
    }
}
