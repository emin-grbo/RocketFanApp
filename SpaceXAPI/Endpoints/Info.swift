import Foundation

enum Info {
    case company
    case api
}

extension Info: Endpoint {
    var path: String {
        switch self {
        case .company:
            return "/info"
        case .api:
            return ""
        }
    }
}
