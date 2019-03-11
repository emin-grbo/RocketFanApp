import Foundation

enum SpaceXAPIError: Error {
    case unknownResponse
    case serverReturnedCode(Int)
    case emptyResponse
}

extension SpaceXAPIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknownResponse:
            return NSLocalizedString("Server returned unknown response", comment: "Server returned unknown response")

        case .serverReturnedCode(let code):
            return NSLocalizedString("Server returned HTTP code \(code)", comment: "Server returned code")

        case .emptyResponse:
            return NSLocalizedString("No data returned by the server", comment: "Missing data error")
        }
    }
}
