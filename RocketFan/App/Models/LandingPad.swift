import Foundation

struct LandingPad: Decodable {
    let details: String
    let fullName: String
    let id: String
    let landing: Landing
    let landingType: String
    let location: Location
    let status: String
    let wikipedia: URL
}

extension LandingPad {
    enum CodingKeys: String, CodingKey {
        case attemptedLandings = "attempted_landings"
        case details
        case fullName = "full_name"
        case id
        case landingType = "landing_type"
        case location
        case status
        case successfulLandings = "successful_landings"
        case wikipedia
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        details = try container.decode(String.self, forKey: .details)
        fullName = try container.decode(String.self, forKey: .fullName)
        id = try container.decode(String.self, forKey: .id)
        landingType = try container.decode(String.self, forKey: .landingType)
        location = try container.decode(Location.self, forKey: .location)
        status = try container.decode(String.self, forKey: .status)
        wikipedia = try container.decode(URL.self, forKey: .wikipedia)

        let attempts = try container.decodeIfPresent(Int.self, forKey: .attemptedLandings)
        let successes = try container.decodeIfPresent(Int.self, forKey: .successfulLandings)
        landing = Landing(attempts: attempts, successes: successes)!
    }
}
