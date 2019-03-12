import Foundation

public enum Roadster {
    case location
}

extension Roadster: Endpoint {
    public var path: String {
        switch self {
        case .location:
            return "/roadster"
        }
    }
}
