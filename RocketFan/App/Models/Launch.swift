// swiftlint:disable nesting

import Foundation

struct Launch: Decodable {
    let details: String?
    let failureDetails: FailureDetails?
    let flightClub: URL?
    let flightNumber: Int
    let isTentative: Bool
    let launchDate: Date?
    let launchWindow: Int?
    let links: Links
    let missionId: [String]
    let missionName: String
    let rocket: Rocket
    let ships: [String]
    let site: Site
    let staticFireDate: Date?
    let tentativeMaxPrecision: String
    let timeline: [String: Int]?
}

extension Launch {
    enum CodingKeys: String, CodingKey {
        case details
        case failureDetails = "launch_failure_details"
        case flightNumber = "flight_number"
        case isTentative = "is_tentative"
        case launchDate = "launch_date_unix"
        case launchWindow = "launch_window"
        case links
        case missionId = "mission_id"
        case missionName = "mission_name"
        case rocket
        case ships
        case site = "launch_site"
        case staticFireDate = "static_fire_date_unix"
        case telemetry
        case tentativeMaxPrecision = "tentative_max_precision"
        case timeline
        /// Nested
        case flightClub = "flight_club"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        details = try container.decodeIfPresent(String.self, forKey: .details)
        failureDetails = try container.decodeIfPresent(FailureDetails.self, forKey: .failureDetails)
        flightNumber = try container.decode(Int.self, forKey: .flightNumber)
        isTentative = try container.decode(Bool.self, forKey: .isTentative)
        launchDate = try container.decodeIfPresent(Date.self, forKey: .launchDate)
        launchWindow = try container.decodeIfPresent(Int.self, forKey: .launchWindow)
        links = try container.decode(Links.self, forKey: .links)
        missionId = try container.decode([String].self, forKey: .missionId)
        missionName = try container.decode(String.self, forKey: .missionName)
        rocket = try container.decode(Rocket.self, forKey: .rocket)
        ships = try container.decode([String].self, forKey: .ships)
        site = try container.decode(Site.self, forKey: .site)
        staticFireDate = try container.decodeIfPresent(Date.self, forKey: .staticFireDate)
        tentativeMaxPrecision = try container.decode(String.self, forKey: .tentativeMaxPrecision)
        timeline = try container.decodeIfPresent([String: Int].self, forKey: .timeline)

        let telemetry = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .telemetry)
        flightClub = try telemetry.decodeIfPresent(URL.self, forKey: .flightClub)
    }
}

extension Launch {
    struct FailureDetails: Decodable, Equatable {
        let altitude: Int?
        let reason: String
        let time: Int
    }
}

extension Launch {
    /// A general struct for storing a site id and name.
    /// Note: these link up with `LandingPad`, but the name feels weird in a Launch model.
    struct Site: Decodable {
        let id: String
        let shortName: String

        enum CodingKeys: String, CodingKey {
            case id = "site_id"
            case shortName = "site_name"
        }
    }
}

extension Launch {
    struct Rocket: Decodable {
        let fairings: Fairings?
        let firstStage: [Core]
        let id: String
        let name: String
        let secondStage: SecondStage
        let type: String

        enum CodingKeys: String, CodingKey {
            case cores
            case fairings
            case firstStage = "first_stage"
            case id = "rocket_id"
            case name = "rocket_name"
            case secondStage = "second_stage"
            case type = "rocket_type"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            fairings = try container.decodeIfPresent(Fairings.self, forKey: .fairings)
            id = try container.decode(String.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)
            secondStage = try container.decode(SecondStage.self, forKey: .secondStage)
            type = try container.decode(String.self, forKey: .type)

            let firstStageContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .firstStage)
            firstStage = try firstStageContainer.decode([Core].self, forKey: .cores)
        }

        struct Fairings: Decodable {
            let recovered: Bool?
            let recoveryAttempt: Bool?
            let reused: Bool
            let ship: String?

            enum Keys: String, CodingKey {
                case recovered
                case recoveryAttempt = "recovery_attempt"
                case reused
                case ship
            }
        }

        struct Core: Decodable {
            let block: Int?
            let flight: Int?
            let gridfins: Bool?
            let landingIntent: Bool?
            let landingSuccessful: Bool?
            let landingType: String?
            let landingVehicle: String?
            let legs: Bool?
            let reused: Bool?
            let serial: String?

            enum Keys: String, CodingKey {
                case block
                case flight
                case gridfins
                case landingIntent = "landing_intent"
                case landingSuccessful = "land_success"
                case landingType = "landing_type"
                case landingVehicle = "landing_vehicle"
                case legs
                case reused
                case serial
            }
        }

        struct SecondStage: Decodable {
            let block: Int?
            let payloads: [Payload]
        }
    }
}
