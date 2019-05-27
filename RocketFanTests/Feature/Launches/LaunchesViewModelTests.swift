import XCTest
@testable import RocketFan

class LaunchesViewModelTests: XCTestCase {
    private var sut: LaunchesViewModel?

    override func setUp() {
        sut = viewModel(with: loadLaunchs())
    }

    override func tearDown() {
        sut = nil
    }

    func test_DidSetOnLaunchesUpdated_LoadsLaunches() {
        let exp = expectation(description: "Check launches are loaded")
        var launchesCount = 0

        sut?.launchesUpdated = { launches in
            launchesCount = launches.count
            exp.fulfill()
        }

        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }

            XCTAssertTrue(launchesCount > 0)
        }
    }

    func test_WhenErrorCondition_CallsModelError() {
        var modelErrorCalled = false
        let exp = expectation(description: "Check model error is called")

        sut = viewModel(with: nil)

        sut?.modelError = { error in
            modelErrorCalled = true
            exp.fulfill()
        }

        // Makes the 'call' in 'didSet'
        sut?.launchesUpdated = { _ in }

        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }

            XCTAssertTrue(modelErrorCalled)
        }
    }

    func test_GivenSearchTerm_ReturnsResults() {
        let exp = expectation(description: "Check launchesUpdated called twice")
        var launchesUpdatedCalledCount = 0
        var launchesCount = 0

        sut?.launchesUpdated = { launches in
            launchesUpdatedCalledCount += 1

            if launchesUpdatedCalledCount > 1 {
                launchesCount = launches.count
                exp.fulfill()
            }
        }

        sut?.findLaunchesMatching("Fal")

        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }

            XCTAssertTrue(launchesUpdatedCalledCount == 2)
            XCTAssertTrue(launchesCount > 1)
        }
    }

    func test_GivenEmptySearchTerm_ReturnsResults() {
        let exp = expectation(description: "Check launchesUpdated returns results")
        var launchesUpdatedCalledCount = 0
        var launchesCount = 0

        sut?.launchesUpdated = { launches in
            launchesUpdatedCalledCount += 1

            if launchesUpdatedCalledCount > 1 {
                launchesCount = launches.count
                exp.fulfill()
            }
        }

        sut?.findLaunchesMatching("")

        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }

            XCTAssertTrue(launchesCount > 1)
        }
    }
}

// Helpers
extension LaunchesViewModelTests {
    private func loadLaunchs() -> [Launch]? {
        let json = JSONLoader.load(.launches)!
        let decoder = JSONDecoder(dateDecodingStrategy: .secondsSince1970)
        return try? decoder.decoded([Launch].self, from: json)
    }

    private func viewModel(with launches: [Launch]?) -> LaunchesViewModel {
        let mockRepo = MockLaunchesRepository(with: launches)
        return LaunchesViewModel(with: mockRepo)
    }
}
