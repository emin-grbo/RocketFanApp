// swiftlint:disable implicitly_unwrapped_optional
import XCTest
@testable import SpaceXAPI

class SpaceXAPITests: XCTestCase {
    var api: SpaceXAPI!
    var sessionMock = SessionMock()
    let endpoint = EndpointMock()
    var okResponse: HTTPURLResponse!
    var badResponse: HTTPURLResponse!

    override func setUp() {
        let url = URL(fileURLWithPath: "")
        okResponse = HTTPURLResponse(url: url,
                                     statusCode: 200,
                                     httpVersion: nil,
                                     headerFields: nil)

        badResponse = HTTPURLResponse(url: url,
                                      statusCode: 404,
                                      httpVersion: nil,
                                      headerFields: nil)

        api = SpaceXAPI(urlSession: sessionMock)
    }

    func test_SpaceXAPI_BuildsURL() {
        _ = api.get(endpoint) { _ in }

        let expectedURL = URL(string: "https://api.spacexdata.com/v3/test")
        XCTAssertEqual(sessionMock.calledURL, expectedURL)
    }

    func test_SpaceXAPI_BuildsURL_WithOptions() {
        let options = SpaceXAPI.Options(limit: 1, offset: 2)

        _ = api.get(endpoint, options: options) { _ in }

        // Query item order isn't guaranteed, so don't try and match an absolute string
        let components = URLComponents(url: sessionMock.calledURL!, resolvingAgainstBaseURL: false)!
        XCTAssertEqual(Set(components.queryItems ?? []), Set(options.queryItems))
    }

    func test_SpaceXAPI_ReturnsTask() {
        let taskMock = DataTaskMock()
        sessionMock.task = taskMock

        let task = api.get(endpoint) { _ in }

        XCTAssertEqual(task, taskMock)
    }

    func test_SpaceXAPI_ResumesTask() {
        let taskMock = DataTaskMock()
        sessionMock.task = taskMock

        _ = api.get(endpoint) { _ in }

        XCTAssertTrue(taskMock.resumeWasCalled)
    }

    func test_SpaceXAPI_WhenGivenError_ReturnsError() {
        let expectedError = ErrorMock.expected
        sessionMock.error = expectedError

        var returnedResult: Result<Data>?
        _ = api.get(endpoint) { result in
            returnedResult = result
        }

        assert(returnedResult, containsError: expectedError)
    }

    func test_SpaceXAPI_WhenGivenEmptyResponse_ReturnsUnknownResponseError() {
        let expectedError = SpaceXAPIError.unknownResponse
        sessionMock.response = nil

        var returnedResult: Result<Data>?
        _ = api.get(endpoint) { result in
            returnedResult = result
        }

        assert(returnedResult, containsError: expectedError)
    }

    func test_SpaceXAPI_WhenGivenServerError_ReturnsError() {
        let error = SpaceXAPIError.serverReturnedCode(404)
        sessionMock.response = badResponse

        var returnedResult: Result<Data>?
        _ = api.get(endpoint) { result in
            returnedResult = result
        }

        assert(returnedResult, containsError: error)
    }

    func test_SpaceXAPI_WhenGivenNoData_ReturnsNoDataError() {
        let error = SpaceXAPIError.emptyResponse
        sessionMock.response = okResponse
        sessionMock.data = nil

        var returnedResult: Result<Data>?
        _ = api.get(endpoint) { result in
            returnedResult = result
        }

        assert(returnedResult, containsError: error)
    }

    func test_SpaceXAPI_WhenGivenData_ReturnsSuccess() {
        let data = "Blast off".data(using: .utf8)!
        sessionMock.response = okResponse
        sessionMock.data = data

        var returnedResult: Result<Data>?
        _ = api.get(endpoint) { result in
            returnedResult = result
        }

        assert(returnedResult, containsData: data)
    }
}
