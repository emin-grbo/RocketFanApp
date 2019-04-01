import Foundation

struct Roadster: Decodable {
    let daysInSpace: Double
    let details: String

    /// Specified in KM and Miles
    let distanceFromEarth: Units

    /// Specified in KM and Miles
    let distanceFromMars: Units
    let launchDate: Date

    /// Specified in Kg and Lbs
    let launchMass: Units

    let links: Links
    let name: String

    /// Specified in Kph and Mph
    let speed: Units

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        launchDate = try container.decode(Date.self, forKey: .launchDate)
        daysInSpace = try container.decode(Double.self, forKey: .daysInSpace)
        details = try container.decode(String.self, forKey: .details)

        let kg = try container.decode(Double.self, forKey: .launchMassKg)
        let lbs = try container.decode(Double.self, forKey: .launchMassLbs)
        launchMass = Units(metric: kg, imperial: lbs)!

        let kph = try container.decode(Double.self, forKey: .kph)
        let mph = try container.decode(Double.self, forKey: .mph)
        speed = Units(metric: kph, imperial: mph)!

        let earthKm = try container.decode(Double.self, forKey: .earthKm)
        let earthMi = try container.decode(Double.self, forKey: .earthMi)
        let marsMi = try container.decode(Double.self, forKey: .marsMi)
        let marsKm = try container.decode(Double.self, forKey: .marsKm)
        distanceFromEarth = Units(metric: earthKm, imperial: earthMi)!
        distanceFromMars = Units(metric: marsMi, imperial: marsKm)!

        let wikipedia = try container.decode(URL.self, forKey: .wikipedia)
        links = Links(wikipedia: wikipedia)
    }
}

extension Roadster {
    enum CodingKeys: String, CodingKey {
        case daysInSpace = "period_days"
        case details
        case earthKm = "earth_distance_km"
        case earthMi = "earth_distance_mi"
        case kph = "speed_kph"
        case launchDate = "launch_date_unix"
        case launchMassKg = "launch_mass_kg"
        case launchMassLbs = "launch_mass_lbs"
        case marsKm = "mars_distance_km"
        case marsMi = "mars_distance_mi"
        case mph = "speed_mph"
        case name
        case wikipedia
    }
}
