// swiftlint:disable nesting

import Foundation

struct Dragon: Decodable {
    let crewCapacity: Int
    let description: String
    let diameter: Units
    let dryMass: Units
    let firstFlight: Date?
    let heatShield: HeatShield
    let height: Units
    let id: String
    let images: [URL]
    let isActive: Bool
    let launchPayloadMass: Units
    let launchPayloadVolume: Units
    let links: Links
    let name: String
    let orbitDurationYear: Int
    let pressurizedCapsulePayloadVolume: Units
    let returnPayloadMass: Units
    let returnPayloadVolume: Units
    let sideWallAngleDegrees: Int
    let thrusters: [Thruster]
    let trunk: Trunk
    let type: String
}

extension Dragon {
    enum CodingKeys: String, CodingKey {
        case crewCapacity = "crew_capacity"
        case description
        case diameter
        case dryMassKG = "dry_mass_kg"
        case dryMassLB = "dry_mass_lb"
        case firstFlight = "first_flight"
        case heatShield = "heat_shield"
        case height = "height_w_trunk"
        case id
        case images = "flickr_images"
        case isActive = "active"
        case launchPayloadMass = "launch_payload_mass"
        case launchPayloadVolume = "launch_payload_vol"
        case name
        case orbitDurationYear = "orbit_duration_yr"
        case payloadVolume = "payload_volume"
        case pressurizedCapsule = "pressurized_capsule"
        case returnPayloadMass = "return_payload_mass"
        case returnPayloadVolume = "return_payload_vol"
        case sideWallAngleDegrees = "sidewall_angle_deg"
        case thrusters
        case trunk
        case type
        case wikipedia
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        crewCapacity = try container.decode(Int.self, forKey: .crewCapacity)
        description = try container.decode(String.self, forKey: .description)
        diameter = try container.decodeDistanceUnits(for: .diameter)
        heatShield = try container.decode(HeatShield.self, forKey: .heatShield)
        height = try container.decodeDistanceUnits(for: .height)
        id = try container.decode(String.self, forKey: .id)
        images = try container.decode([URL].self, forKey: .images)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        launchPayloadMass = try container.decodeMassUnits(for: .launchPayloadMass)
        launchPayloadVolume = try container.decodeVolumeUnits(for: .launchPayloadVolume)
        name = try container.decode(String.self, forKey: .name)
        orbitDurationYear = try container.decode(Int.self, forKey: .orbitDurationYear)
        returnPayloadMass = try container.decodeMassUnits(for: .returnPayloadMass)
        returnPayloadVolume = try container.decodeVolumeUnits(for: .returnPayloadVolume)
        sideWallAngleDegrees = try container.decode(Int.self, forKey: .sideWallAngleDegrees)
        thrusters = try container.decode([Thruster].self, forKey: .thrusters)
        trunk = try container.decode(Trunk.self, forKey: .trunk)
        type = try container.decode(String.self, forKey: .type)

        let massKG = try container.decode(Double.self, forKey: .dryMassKG)
        let massLB = try container.decode(Double.self, forKey: .dryMassLB)
        dryMass = Units(metric: massKG, imperial: massLB)!

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = try container.decode(String.self, forKey: .firstFlight)
        firstFlight = formatter.date(from: date)

        let wikipedia = try container.decode(URL.self, forKey: .wikipedia)
        links = Links(wikipedia: wikipedia)

        let capsuleContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .pressurizedCapsule)
        pressurizedCapsulePayloadVolume = try capsuleContainer.decodeVolumeUnits(for: .payloadVolume)
    }
}

extension Dragon {
    struct HeatShield: Decodable {
        let developmentPartner: String
        let material: String
        let sizeMeters: Double
        let temperatureDegrees: Int

        enum CodingKeys: String, CodingKey {
            case developmentPartner = "dev_partner"
            case material
            case sizeMeters = "size_meters"
            case temperatureDegrees = "temp_degrees"
        }
    }
}

extension Dragon {
    struct Thruster: Decodable {
        let amount: Int
        let fuel: [String]
        let pods: Int
        let thrust: Units
        let type: String

        enum CodingKeys: String, CodingKey {
            case amount
            case pods
            case thrust
            case type
            case fuel1 = "fuel_1"
            case fuel2 = "fuel_2"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            amount = try container.decode(Int.self, forKey: .amount)
            pods = try container.decode(Int.self, forKey: .pods)
            thrust = try container.decodeForceUnits(for: .thrust)
            type = try container.decode(String.self, forKey: .type)

            // Potentially there will be more fuels coming, so lets use an array of fuel
            let fuel1 = try container.decode(String.self, forKey: .fuel1)
            let fuel2 = try container.decode(String.self, forKey: .fuel2)
            fuel = [fuel1, fuel2]

        }
    }
}

extension Dragon {
    struct Trunk: Decodable {
        let solarArray: Int
        let unpressurizedCargo: Bool
        let volume: Units

        enum Keys: String, CodingKey {
            case cargo
            case solarArray = "solar_array"
            case unpressurisedCargo = "unpressurized_cargo"
            case volume = "trunk_volume"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Keys.self)

            volume = try container.decodeVolumeUnits(for: .volume)

            let cargoContainer = try container.nestedContainer(keyedBy: Keys.self, forKey: .cargo)
            solarArray = try cargoContainer.decode(Int.self, forKey: .solarArray)
            unpressurizedCargo = try cargoContainer.decode(Bool.self, forKey: .unpressurisedCargo)
        }
    }
}
