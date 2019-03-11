import Foundation

enum History {
    case all
    case one(String)
}

extension History: Endpoint {
    var path: String {
        switch self {
        case .all:
            return "/history"
        case .one(let id):
            return "/history/\(id)"
        }
    }
}
