import Foundation
@testable import SpaceXAPI

/// A partial mock that reports if `.resume()` was called
class DataTaskMock: URLSessionDataTask {
    var resumeWasCalled = false
    override func resume() {
        resumeWasCalled = true
    }
}

/// A network session that allows returning stubbed data
class SessionMock: NetworkSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    var task: URLSessionDataTask?

    var urlCalled: String?

    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        urlCalled = url.absoluteString
        completionHandler(data, response, error)
        return task ?? DataTaskMock()
    }
}

/// A stubbed endpoint
struct EndpointMock: Endpoint {
    var path: String {
        return "/test"
    }
}

/// A stubbed error
enum ErrorMock: Error {
    case expected
}
