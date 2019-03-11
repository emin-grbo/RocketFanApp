import Foundation

enum Capsules {
    case all
    case one(String)
    case upcoming
    case past
}

extension Capsules: Endpoint {
    var path: String {
        switch self {
        case .all:
            return "/capsules"
        case .one(let capsuleSerial):
            return "/capsules/\(capsuleSerial)"
        case .upcoming:
            return "/capsules/upcoming"
        case .past:
            return  "/capsules/past"
        }
    }
}
