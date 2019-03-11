import Foundation

enum Roadster {
    case current
}

extension Roadster: Endpoint {
    var path: String {
        switch self {
        case .current:
            return "/roadster"
        }
    }
}
