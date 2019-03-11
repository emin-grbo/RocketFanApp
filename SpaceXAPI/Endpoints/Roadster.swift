import Foundation

enum Roadster {
    case location
}

extension Roadster: Endpoint {
    var path: String {
        switch self {
        case .location:
            return "/roadster"
        }
    }
}
