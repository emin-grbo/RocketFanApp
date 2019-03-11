import Foundation

enum Payloads {
    case all
    case one(String)
}

extension Payloads: Endpoint {
    var path: String {
        switch self {
        case .all:
            return "/payloads"
        case .one(let payloadId):
            return "/payloads/\(payloadId)"
        }
    }
}
