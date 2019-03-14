import Foundation

struct Capsule: Codable {
    let id: String
    let serial: String
    let status: String
    let landings: Int
    let type: String
    let details: String?
    let reuseCount: Int
    let originalLaunch: Date?
    let missions: [MissionFragment]
}

extension Capsule {
    enum CodingKeys: String, CodingKey {
        case id = "capsule_id"
        case serial = "capsule_serial"
        case status
        case landings
        case type
        case details
        case reuseCount = "reuse_count"
        case originalLaunch = "original_launch_unix"
        case missions
    }
}
