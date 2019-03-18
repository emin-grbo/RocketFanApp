import Foundation

struct Ship: Decodable {
    typealias Weight = Units

    let courseDeg: Int?
    let homePort: String
    let id: String
    let identifiers: Identifiers?
    let imageUrl: URL?
    let isActive: Bool
    let landings: Landings?
    let location: Location?
    let missions: [MissionFragment]
    let model: String?
    let name: String
    let roles: [String]
    let speed: Speed?
    let status: String?
    let url: URL?
    let weight: Weight?
    let yearBuilt: Int?
}

extension Ship {
    enum CodingKeys: String, CodingKey {
        case abs
        case attemptedLandings = "attempted_landings"
        case courseDeg = "course_deg"
        case homePort = "home_port"
        case id = "ship_id"
        case imageUrl = "image"
        case imo
        case isActive = "active"
        case location = "position"
        case missions
        case mmsi
        case model = "ship_model"
        case name = "ship_name"
        case roles
        case speedKn = "speed_kn"
        case status
        case successfulLandings = "successful_landings"
        case url
        case weightKg = "weight_kg"
        case weightLbs = "weight_lbs"
        case yearBuilt = "year_built"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        courseDeg = try container.decodeIfPresent(Int.self, forKey: .courseDeg)
        homePort = try container.decode(String.self, forKey: .homePort)
        id = try container.decode(String.self, forKey: .id)
        imageUrl = try container.decodeIfPresent(URL.self, forKey: .imageUrl)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        location = try? container.decode(Location.self, forKey: .location)
        missions = try container.decode([MissionFragment].self, forKey: .missions)
        model = try container.decodeIfPresent(String.self, forKey: .model)
        name = try container.decode(String.self, forKey: .name)
        roles = try container.decode([String].self, forKey: .roles)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        url = try container.decodeIfPresent(URL.self, forKey: .url)
        yearBuilt = try container.decodeIfPresent(Int.self, forKey: .yearBuilt)

        let kn = try container.decodeIfPresent(Double.self, forKey: .speedKn)
        speed = Speed(kn: kn)

        let lbs = try container.decodeIfPresent(Double.self, forKey: .weightLbs)
        let kg = try container.decodeIfPresent(Double.self, forKey: .weightKg)
        weight = Weight(metric: kg, imperial: lbs)

        let attempted = try container.decodeIfPresent(Int.self, forKey: .attemptedLandings)
        let successful = try container.decodeIfPresent(Int.self, forKey: .successfulLandings)
        landings = Landings(attempted: attempted, successful: successful)

        let imo = try container.decodeIfPresent(Int.self, forKey: .imo)
        let mmsi = try container.decodeIfPresent(Int.self, forKey: .mmsi)
        let abs = try container.decodeIfPresent(Int.self, forKey: .abs)
        identifiers = Identifiers(abs: abs, imo: imo, mmsi: mmsi)
    }
}

extension Ship {
    struct Identifiers {
        /// American Bureau of Shipping
        let abs: Int

        /// International Maritime Organisation
        let imo: Int

        /// Maritime Mobile Service Identity
        let mmsi: Int

        init?(abs: Int?, imo: Int?, mmsi: Int?) {
            guard let abs = abs, let imo = imo, let mmsi = mmsi else { return nil }

            self.abs = abs
            self.imo = imo
            self.mmsi = mmsi
        }
    }
}
