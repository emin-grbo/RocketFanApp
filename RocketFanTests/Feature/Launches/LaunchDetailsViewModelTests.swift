import XCTest

@testable
import RocketFan

class LaunchDetailsViewModelTests: XCTestCase {
    var launch: Launch!
    var viewModel: LaunchDetailsViewModel!

    override func setUp() {
        super.setUp()
        launch = loadLaunch()
        viewModel = LaunchDetailsViewModel(launch: launch)
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

    // MARK: - Test Helpers

    private func loadLaunch() -> Launch? {
        let json = JSONLoader.load(.launches)!
        let decoder = JSONDecoder(dateDecodingStrategy: .secondsSince1970)
        let launches = try? decoder.decoded([Launch].self, from: json)
        return launches?.first(where: { $0.flightNumber == 1 })
    }
}
