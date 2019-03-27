import Foundation

struct Capsule: Decodable {
    let details: String?
    let id: String
    let landings: Int
    let missions: [MissionFragment]
    let originalLaunch: Date?
    let reuseCount: Int
    let serial: String
    let status: String
    let type: String
}

extension Capsule {
    enum CodingKeys: String, CodingKey {
        case details
        case id = "capsule_id"
        case landings
        case missions
        case originalLaunch = "original_launch_unix"
        case reuseCount = "reuse_count"
        case serial = "capsule_serial"
        case status
        case type
    }
}
