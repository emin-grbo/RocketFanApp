import Foundation

struct Ship: Decodable {
    let id: String
    let name: String
    let model: String?
    let isActive: Bool
    let imo: Double?
    let mmsi: Double?
    let abs: Double?
    let weight: Weight?
    let yearBuilt: Int?
    let homePort: String
    let status: String?
    let speedKn: Double?
    let courseDeg: Int?
    let location: Location?
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
        case location = "position"
        case successfulLandings = "successful_landings"
        case attemptedLandings = "attempted_landings"
        case missions
        case url
        case imageUrl = "image"
        case roles
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        model = try container.decodeIfPresent(String.self, forKey: .model)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        imo = try container.decodeIfPresent(Double.self, forKey: .imo)
        mmsi = try container.decodeIfPresent(Double.self, forKey: .mmsi)
        abs = try container.decodeIfPresent(Double.self, forKey: .abs)
        yearBuilt = try container.decodeIfPresent(Int.self, forKey: .yearBuilt)
        homePort = try container.decode(String.self, forKey: .homePort)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        speedKn = try container.decodeIfPresent(Double.self, forKey: .speedKn)
        courseDeg = try container.decodeIfPresent(Int.self, forKey: .courseDeg)
        location = try? container.decode(Location.self, forKey: .location)
        successfulLandings = try container.decodeIfPresent(Int.self, forKey: .successfulLandings)
        attemptedLandings = try container.decodeIfPresent(Int.self, forKey: .attemptedLandings)
        missions = try container.decode([MissionFragment].self, forKey: .missions)
        url = try container.decodeIfPresent(URL.self, forKey: .url)
        imageUrl = try container.decodeIfPresent(URL.self, forKey: .imageUrl)
        roles = try container.decode([String].self, forKey: .roles)

        let lbs = try container.decodeIfPresent(Int.self, forKey: .weightLbs)
        let kg = try container.decodeIfPresent(Int.self, forKey: .weightKg)
        weight = Weight(kg: kg, lbs: lbs)
    }
}
