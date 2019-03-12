import Foundation

public enum Info {
    case company
    case api
}

extension Info: Endpoint {
    public var path: String {
        switch self {
        case .company:
            return "/info"
        case .api:
            ///// API info requires no path, so returning an empty string is intentional
            return ""
        }
    }
}
