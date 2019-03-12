import Foundation

public enum Missions {
    case all
    case one(String)
}

extension Missions: Endpoint {
    public var path: String {
        switch self {
        case .all:
            return "/missions"
        case .one(let missionId):
            return "/missions/\(missionId)"
        }
    }
}
