import Foundation

public enum LaunchPads {
    case all
    case one(String)
}

extension LaunchPads: Endpoint {
    public var path: String {
        switch self {
        case .all:
            return "/launchpads"
        case .one(let siteId):
            return "/launchpads/\(siteId)"
        }
    }
}
