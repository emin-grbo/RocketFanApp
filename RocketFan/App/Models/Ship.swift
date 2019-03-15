import Foundation

struct Ship: Decodable {
    let id: String
    let name: String
    let model: String?
    let isActive: Bool
    let imo: Double?
    let mmsi: Double?
    let abs: Double?
    let weightLbs: Double?
    let weightKg: Double?
    let yearBuilt: Double?
    let homePort: String
    let status: String?
    let speedKn: Double?
    let courseDeg: Int?
    let position: Position
    let successfulLandings: Int?
    let attemptedLandings: Int?
    let missions: [MissionFragment]
    let url: URL?
    let imageUrl: URL?
    let roles: [String]
}

extension Ship {
    enum CodingKeys: String, CodingKey {
        case id = "ship_id"
        case name = "ship_name"
        case model = "ship_model"
        case isActive = "active"
        case imo
        case mmsi
        case abs
        case weightLbs = "weight_lbs"
        case weightKg = "weight_kg"
        case yearBuilt = "year_built"
        case homePort = "home_port"
        case status
        case speedKn = "speed_kn"
        case courseDeg = "course_deg"
        case position
        case successfulLandings = "successful_landings"
        case attemptedLandings = "attempted_landings"
        case missions
        case url
        case imageUrl = "image"
        case roles
    }
}
