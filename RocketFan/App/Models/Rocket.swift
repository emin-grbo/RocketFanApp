// swiftlint:disable nesting

import Foundation

struct Rocket: Decodable {
    let boosters: Int
    let company: String
    let costPerLaunch: Double
    let country: String
    let description: String
    let diameter: Units
    let engine: Engine
    let firstFlight: Date
    let firstStage: Stage
    let height: Units
    let id: String
    let images: [URL]
    let isActive: Bool
    let landingLegs: LandingLegs
    let links: Links
    let mass: Units
    let stageCount: Int
    let name: String
    let payloadWeights: [PayloadWeight]
    let secondStage: Stage
    let successRatePct: Double
    let type: String
}

extension Rocket {
    enum CodingKeys: String, CodingKey {
        case boosters
        case company
        case costPerLaunch = "cost_per_launch"
        case country
        case description
        case diameter
        case engine = "engines"
        case firstFlight = "first_flight"
        case firstStage = "first_stage"
        case height
        case id = "rocket_id"
        case images = "flickr_images"
        case isActive = "active"
        case landingLegs = "landing_legs"
        case mass
        case name = "rocket_name"
        case payloadWeight = "payload_weights"
        case secondStage = "second_stage"
        case stageCount = "stages"
        case successRatePct = "success_rate_pct"
        case type = "rocket_type"
        case wikipedia
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        stageCount = try container.decode(Int.self, forKey: .stageCount)
        boosters = try container.decode(Int.self, forKey: .boosters)
        costPerLaunch = try container.decode(Double.self, forKey: .costPerLaunch)
        successRatePct = try container.decode(Double.self, forKey: .successRatePct)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        country = try container.decode(String.self, forKey: .country)
        company = try container.decode(String.self, forKey: .company)
        description = try container.decode(String.self, forKey: .description)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        diameter = try container.decodeDistanceUnits(for: .diameter)
        height = try container.decodeDistanceUnits(for: .height)
        mass = try container.decodeMassUnits(for: .mass)
        payloadWeights = try container.decode([PayloadWeight].self, forKey: .payloadWeight)
        firstStage = try container.decode(Stage.self, forKey: .firstStage)
        secondStage = try container.decode(Stage.self, forKey: .secondStage)
        engine = try container.decode(Engine.self, forKey: .engine)
        landingLegs = try container.decode(LandingLegs.self, forKey: .landingLegs)
        images = try container.decode([URL].self, forKey: .images)

        let wikipedia = try container.decode(URL.self, forKey: .wikipedia)
        links = Links(wikipedia: wikipedia)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = try container.decode(String.self, forKey: .firstFlight)
        firstFlight = formatter.date(from: date)!
    }
}

extension Rocket {
    struct Engine: Decodable {
        let layout: String?
        let losMax: Int?
        let number: Int
        let propellants: [String]
        let thrustSeaLevel: Units?
        let thrustToWeight: Double?
        let thrustVacuum: Units?
        let type: String

        enum CodingKeys: String, CodingKey {
            case layout
            case losMax = "engine_loss_max"
            case number
            case propellant1 = "propellant_1"
            case propellant2 = "propellant_2"
            case thrustSeaLevel = "thrust_sea_level"
            case thrustToWeight = "thrust_to_weight"
            case thrustVacuum = "thrust_vacuum"
            case type
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            number = try container.decode(Int.self, forKey: .number)
            losMax = try? container.decode(Int.self, forKey: .losMax)
            type = try container.decode(String.self, forKey: .type)
            layout = try? container.decode(String.self, forKey: .layout)
            thrustSeaLevel = try container.decodeForceUnits(for: .thrustSeaLevel)
            thrustVacuum = try?container.decodeForceUnits(for: .thrustVacuum)
            thrustToWeight = try? container.decode(Double.self, forKey: .thrustToWeight)

            // Potentially there will be more propellants coming, so lets use an array of propellants
            let propellant1 = try container.decode(String.self, forKey: .propellant1)
            let propellant2 = try container.decode(String.self, forKey: .propellant2)
            propellants = [propellant1, propellant2]
        }
    }
}

extension Rocket {
    struct Stage: Decodable {
        let burnTimeSec: Int?
        let engines: Int
        let fuelAmountTons: Double
        let isReuseable: Bool
        let payloads: Payloads?
        let thrust: Units?
        let thrustSeaLevel: Units?
        let thrustVacuum: Units?

        enum CodingKeys: String, CodingKey {
            case burnTimeSec = "burn_time_sec"
            case engines
            case fuelAmountTons = "fuel_amount_tons"
            case isReuseable = "reusable"
            case payloads
            case thrust
            case thrustSeaLevel = "thrust_sea_level"
            case thrustVacuum = "thrust_vacuum"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            isReuseable = try container.decode(Bool.self, forKey: .isReuseable)
            engines = try container.decode(Int.self, forKey: .engines)
            fuelAmountTons = try container.decode(Double.self, forKey: .fuelAmountTons)
            burnTimeSec = try? container.decode(Int.self, forKey: .burnTimeSec)
            thrustSeaLevel = try? container.decodeForceUnits(for: .thrustSeaLevel)
            thrustVacuum = try? container.decodeForceUnits(for: .thrustVacuum)
            thrust = try? container.decodeForceUnits(for: .thrust)
            payloads = try? container.decode(Payloads.self, forKey: .payloads)
        }
    }
}

extension Rocket {
    struct LandingLegs: Decodable {
        let material: String?
        let number: Int
    }
}

extension Rocket {
    struct PayloadWeight: Decodable {
        let id: String
        let name: String
        let weight: Units

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case weightKg = "kg"
            case weightLb = "lb"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            id = try container.decode(String.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)

            let kg = try container.decode(Double.self, forKey: .weightKg)
            let lb = try container.decode(Double.self, forKey: .weightLb)
            weight = Units(metric: kg, imperial: lb)!
        }
    }
}

extension Rocket.Stage {
    struct Payloads: Decodable {
        let compositeFairing: CompositeFairing
        let option1: String
        let option2: String

        enum CodingKeys: String, CodingKey {
            case compositeFairing = "composite_fairing"
            case option1 = "option_1"
            case option2 = "option_2"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            compositeFairing = try container.decode(CompositeFairing.self, forKey: .compositeFairing)
            option1 = try container.decode(String.self, forKey: .option1)
            option2 = try container.decode(String.self, forKey: .option2)
        }
    }
}

extension Rocket.Stage.Payloads {
    struct CompositeFairing: Decodable {
        let diameter: Units
        let height: Units

        enum CodingKeys: String, CodingKey {
            case diameter
            case height
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            diameter = try container.decodeDistanceUnits(for: .diameter)
            height = try container.decodeDistanceUnits(for: .height)
        }
    }
}
