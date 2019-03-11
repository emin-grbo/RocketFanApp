import Foundation

enum Dragons {
    case all
    case one(String)
}

extension Dragons: Endpoint {
    var path: String {
        switch self {
        case .all:
            return "/dragons"
        case .one(let id):
            return "/dragons/\(id)"
        }
    }
}
