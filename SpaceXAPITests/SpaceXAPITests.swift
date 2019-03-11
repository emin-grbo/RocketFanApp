// swiftlint:disable implicitly_unwrapped_optional
import XCTest
@testable import SpaceXAPI

class SpaceXAPITests: XCTestCase {
    var api: SpaceXAPI!
    var sessionMock = SessionMock()

    override func setUp() {
        api = SpaceXAPI(urlSession: sessionMock)
    }

    func test_SpaceXAPI_BuildsURL() {
        let endpoint = EndpointMock()

        _ = api.get(endpoint) { _ in }

        XCTAssertEqual(sessionMock.urlCalled, "https://api.spacexdata.com/v3/test")
    }

    func test_SpaceXAPI_ReturnsTask() {
        let taskMock = DataTaskMock()
        sessionMock.task = taskMock

        let task = api.get(EndpointMock()) { _ in }

        XCTAssertEqual(task, taskMock)
    }

    func test_SpaceXAPI_ResumesTask() {
        let taskMock = DataTaskMock()
        sessionMock.task = taskMock

        _ = api.get(EndpointMock()) { _ in }

        XCTAssertTrue(taskMock.resumeWasCalled)
    }
}
