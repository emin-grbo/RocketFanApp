import XCTest
@testable import RocketFan

class LaunchesViewModelTests: XCTestCase {
    private var sut: LaunchesViewModel?

    override func setUp() {
        sut = viewModel()
    }

    override func tearDown() {
        sut = nil
    }
}

// Helpers
extension LaunchesViewModelTests {
    private func viewModel() -> LaunchesViewModel {
        let mockRepo = MockLaunchesRepository(with: launchesTestData)
        return LaunchesViewModel(with: mockRepo)
    }
}
