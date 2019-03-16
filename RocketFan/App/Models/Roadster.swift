import Foundation

struct Roadster: Decodable {
    typealias Mass = Units

    let astronomicalUnits: AstronomicalUnits
    let daysInSpace: Double
    let details: String
    let distance: Distance
    let eccentricity: Double
    let epochJd: Double
    let inclination: Double
    let launchDate: Date
    let launchMass: Mass
    let links: Links
    let name: String
    let noradId: Int
    let orbitType: String
    let periapsisOrg: Double
    let speed: Speed

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        launchDate = try container.decode(Date.self, forKey: .launchDate)
        eccentricity = try container.decode(Double.self, forKey: .eccentricity)
        inclination = try container.decode(Double.self, forKey: .inclination)
        periapsisOrg = try container.decode(Double.self, forKey: .periapsisOrg)
        daysInSpace = try container.decode(Double.self, forKey: .daysInSpace)
        noradId = try container.decode(Int.self, forKey: .noradId)
        epochJd = try container.decode(Double.self, forKey: .epochJd)
        orbitType = try container.decode(String.self, forKey: .orbitType)
        details = try container.decode(String.self, forKey: .details)

        let kg = try container.decode(Int.self, forKey: .launchMassKg)
        let lbs = try container.decode(Int.self, forKey: .launchMassLbs)
        launchMass = Mass(kg: kg, lbs: lbs)!

        let apoapsis = try container.decode(Double.self, forKey: .apoapsis)
        let periapsis = try container.decode(Double.self, forKey: .periapsis)
        let semiMajorAxis = try container.decode(Double.self, forKey: .semiMajorAxis)
        astronomicalUnits = AstronomicalUnits(apoapsis: apoapsis,
                                              periapsis: periapsis,
                                              semiMajorAxis: semiMajorAxis)

        let kph = try container.decode(Double.self, forKey: .kph)
        let mph = try container.decode(Double.self, forKey: .mph)
        speed = Speed(kph: kph, mph: mph)!

        let earthKm = try container.decode(Double.self, forKey: .earthKm)
        let earthMi = try container.decode(Double.self, forKey: .earthMi)
        let marsMi = try container.decode(Double.self, forKey: .marsMi)
        let marsKm = try container.decode(Double.self, forKey: .marsKm)
        distance = Distance(fromEarthKm: earthKm,
                            fromEarthMi: earthMi,
                            fromMarsKm: marsKm,
                            fromMarsMi: marsMi)!

        let wikipedia = try container.decode(URL.self, forKey: .wikipedia)
        links = Links(wikipedia: wikipedia)
    }
}

extension Roadster {
    enum CodingKeys: String, CodingKey {
        case apoapsis = "apoapsis_au"
        case daysInSpace = "period_days"
        case details
        case earthKm = "earth_distance_km"
        case earthMi = "earth_distance_mi"
        case eccentricity
        case epochJd = "epoch_jd"
        case inclination
        case kph = "speed_kph"
        case launchDate = "launch_date_unix"
        case launchMassKg = "launch_mass_kg"
        case launchMassLbs = "launch_mass_lbs"
        case marsKm = "mars_distance_km"
        case marsMi = "mars_distance_mi"
        case mph = "speed_mph"
        case name
        case noradId = "norad_id"
        case orbitType = "orbit_type"
        case periapsis = "periapsis_au"
        case periapsisOrg = "periapsis_arg"
        case semiMajorAxis = "semi_major_axis_au"
        case wikipedia
    }
}
extension Roadster {
    struct AstronomicalUnits {
        let apoapsis: Double
        let periapsis: Double
        let semiMajorAxis: Double

        init(apoapsis: Double,
             periapsis: Double,
             semiMajorAxis: Double) {

            self.apoapsis = apoapsis
            self.periapsis = periapsis
            self.semiMajorAxis = semiMajorAxis
        }
    }
}
