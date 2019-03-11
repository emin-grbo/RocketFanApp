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
            ///// API info requires no path, so returning an empty string is intentional
            return ""
        }
    }
}
