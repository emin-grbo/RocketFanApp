import Foundation

public enum Rockets {
    case all
    case one(String)
}

extension Rockets: Endpoint {
    public var path: String {
        switch self {
        case .all:
            return "/rockets"
        case .one(let rocketId):
            return "/rockets/\(rocketId)"
        }
    }
}
