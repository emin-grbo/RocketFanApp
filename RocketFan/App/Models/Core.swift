import Foundation

struct Core: Decodable {
    let block: Int?
    let details: String?
    let droneShipLanding: Landing
    let launchSiteLanding: Landing
    let missions: [MissionFragment]
    let originalLaunch: Date?
    let reuseCount: Int
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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        block = try container.decodeIfPresent(Int.self, forKey: .block)
        details = try container.decodeIfPresent(String.self, forKey: .details)
        missions = try container.decode([MissionFragment].self, forKey: .missions)
        originalLaunch = try container.decodeIfPresent(Date.self, forKey: .originalLaunch)
        reuseCount = try container.decode(Int.self, forKey: .reuseCount)
        serial = try container.decode(String.self, forKey: .serial)
        status = try container.decode(String.self, forKey: .status)
        waterLanding = try container.decode(Bool.self, forKey: .waterLanding)

        var attempts = try container.decode(Int.self, forKey: .asdsAttempts)
        var successes = try container.decode(Int.self, forKey: .asdsLandings)
        droneShipLanding = Landing(attempts: attempts, successes: successes)!

        attempts = try container.decode(Int.self, forKey: .rtlsAttempts)
        successes = try container.decode(Int.self, forKey: .rtlsLandings)
        launchSiteLanding = Landing(attempts: attempts, successes: successes)!
    }
}
