import Foundation

struct Core: Decodable {
    let asdsAttempts: Int
    let asdsLandings: Int
    let block: Int?
    let details: String?
    let missions: [MissionFragment]
    let originalLaunch: Date?
    let reuseCount: Int
    let rtlsAttempts: Int
    let rtlsLandings: Int
    let serial: String
    let status: String
    let waterLanding: Bool
}

extension Core {
    enum CodingKeys: String, CodingKey {
        case asdsAttempts = "asds_attempts"
        case asdsLandings = "asds_landings"
        case block
        case details
        case missions
        case originalLaunch = "original_launch_unix"
        case reuseCount = "reuse_count"
        case rtlsAttempts = "rtls_attempts"
        case rtlsLandings = "rtls_landings"
        case serial = "core_serial"
        case status
        case waterLanding = "water_landing"
    }
}
