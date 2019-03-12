import Foundation

public enum Launches {
    case all
    case one(String)
    case past
    case upcoming
    case latest
    case next
}

extension Launches: Endpoint {
    public var path: String {
        switch self {
        case .all:
            return "/launches"
        case .one(let flightNumber):
            return "/launches/\(flightNumber)"
        case .past:
            return "/launches/past"
        case .upcoming:
            return "/launches/upcoming"
        case .latest:
            return "/launches/latest"
        case .next:
            return "/launches/next"
        }
    }
}
