import Foundation

public enum LandingPads {
    case all
    case one(String)
}

extension LandingPads: Endpoint {
    public var path: String {
        switch self {
        case .all:
            return "/landpads"
        case .one(let id):
            return "/landpads/\(id)"
        }
    }
}
