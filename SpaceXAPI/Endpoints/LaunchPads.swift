import Foundation

enum LaunchPads {
    case all
    case one(String)
}

extension LaunchPads: Endpoint {
    var path: String {
        switch self {
        case .all:
            return "/launchpads"
        case .one(let siteId):
            return "/launchpads/\(siteId)"
        }
    }
}
