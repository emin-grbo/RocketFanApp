import Foundation

public enum Ships {
    case all
    case one(String)
}

extension Ships: Endpoint {
    public var path: String {
        switch self {
        case .all:
            return "/ships"
        case .one(let shipId):
            return "/ships/\(shipId)"
        }
    }
}
