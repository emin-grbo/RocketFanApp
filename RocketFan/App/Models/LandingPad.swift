import Foundation

struct LandingPad: Decodable {
    let attemptedLandings: Int
    let details: String
    let fullName: String
    let id: String
    let landingType: String
    let location: Location
    let status: String
    let successfulLandings: Int
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
}
