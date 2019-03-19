// swiftlint:disable nesting

import Foundation

struct Payload: Decodable {
    let customers: [String]
    let id: String
    let manufacturer: String?
    let mass: Units?
    let nationality: String?
    let noradIds: [Int]
    let orbit: String
    let orbitParams: OrbitParams
    let payloadType: String
    let reused: Bool
}

extension Payload {
    enum CodingKeys: String, CodingKey {
        case customers
        case id = "payload_id"
        case manufacturer
        case nationality
        case noradIds = "norad_id"
        case orbit
        case orbitParams = "orbit_params"
        case payloadMassKg = "payload_mass_kg"
        case payloadMassLbs = "payload_mass_lbs"
        case payloadType = "payload_type"
        case reused
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        manufacturer = try? container.decode(String.self, forKey: .manufacturer)
        nationality = try? container.decode(String.self, forKey: .nationality)
        payloadType = try container.decode(String.self, forKey: .payloadType)
        orbit = try container.decode(String.self, forKey: .orbit)
        noradIds = try container.decode(Array.self, forKey: .noradIds)
        customers = try container.decode(Array.self, forKey: .customers)
        reused = try container.decode(Bool.self, forKey: .reused)
        orbitParams = try container.decode(OrbitParams.self, forKey: .orbitParams)

        let massKG = try? container.decode(Double.self, forKey: .payloadMassKg)
        let massLBS = try? container.decode(Double.self, forKey: .payloadMassLbs)
        mass = Units(metric: massKG, imperial: massLBS)
    }
}

extension Payload {
    struct OrbitParams: Decodable {
        let apoapsisKm: Double?
        let argOfPericenter: Double?
        let eccentricity: Double?
        let inclinationDeg: Double?
        let lifespanYears: Double?
        let meanAnomaly: Double?
        let meanMotion: Double?
        let periapsisKm: Double?
        let periodMin: Double?
        let raan: Double?
        let referenceSystem: String?
        let regime: String?
        let semiMajorAxisKm: Double?

        enum CodingKeys: String, CodingKey {
            case apoapsisKm = "apoapsis_km"
            case argOfPericenter = "arg_of_pericenter"
            case eccentricity
            case inclinationDeg = "inclination_deg"
            case lifespanYears = "lifespan_years"
            case meanAnomaly = "mean_anomaly"
            case meanMotion = "mean_motion"
            case periapsisKm = "periapsis_km"
            case periodMin = "period_min"
            case raan
            case referenceSystem = "reference_system"
            case regime
            case semiMajorAxisKm = "semi_major_axis_km"
        }
    }
}
