import Foundation

struct Company: Decodable {
    let employeeCount: Int
    let founder: String
    let headquarters: Headquarters
    let launchSiteCount: Int
    let links: Links
    let name: String
    let officers: Officers
    let summary: String
    let testSiteCount: Int
    let valuation: Double
    let yearFounded: Int
}

extension Company {
    enum CodingKeys: String, CodingKey {
        case ceo
        case coo
        case cto
        case ctoPropulsion = "cto_propulsion"
        case employeeCount = "employees"
        case founder
        case headquarters
        case launchSiteCount = "launch_sites"
        case links
        case name
        case summary
        case testSiteCount = "test_sites"
        case valuation
        case yearFounded = "founded"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        employeeCount = try container.decode(Int.self, forKey: .employeeCount)
        yearFounded = try container.decode(Int.self, forKey: .yearFounded)
        founder = try container.decode(String.self, forKey: .founder)
        name = try container.decode(String.self, forKey: .name)
        launchSiteCount = try container.decode(Int.self, forKey: .launchSiteCount)
        testSiteCount = try container.decode(Int.self, forKey: .testSiteCount)
        valuation = try container.decode(Double.self, forKey: .valuation)
        links = try container.decodeIfPresent(Links.self, forKey: .links)!
        headquarters = try container.decodeIfPresent(Headquarters.self, forKey: .headquarters)!
        summary = try container.decode(String.self, forKey: .summary)

        let ceo = try container.decode(String.self, forKey: .ceo)
        let coo = try container.decode(String.self, forKey: .coo)
        let cto = try container.decode(String.self, forKey: .cto)
        let ctoPropulsion = try container.decode(String.self, forKey: .ctoPropulsion)
        officers = Officers(ceo: ceo,
                            coo: coo,
                            cto: cto,
                            ctoPropulsion: ctoPropulsion)
    }
}

extension Company {
    struct Officers {
        let ceo: String
        let coo: String
        let cto: String
        let ctoPropulsion: String
    }
}

extension Company {
    struct Headquarters: Decodable {
        let address: String
        let city: String
        let state: String
    }
}
