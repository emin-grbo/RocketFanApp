import Foundation

enum Rockets {
    case all
    case one(String)
}

extension Rockets: Endpoint {
    var path: String {
        switch self {
        case .all:
            return "/rockets"
        case .one(let rocketId):
            return "/rockets/\(rocketId)"
        }
    }
}
