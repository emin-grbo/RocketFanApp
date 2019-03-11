import Foundation

enum SpaceXAPIError: Error {
    case unknownReponse
    case serverReturnedCode(Int)
    case noDataReceived
}

extension SpaceXAPIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknownReponse:
            return NSLocalizedString("Server returned unknown response", comment: "Server returned unknown response")

        case .serverReturnedCode(let code):
            return NSLocalizedString("Server returned HTTP code \(code)", comment: "Server returned code")

        case .noDataReceived:
            return NSLocalizedString("No data returned by the server", comment: "Missing data error")
        }
    }
}
