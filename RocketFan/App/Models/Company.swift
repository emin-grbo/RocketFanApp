import Foundation

struct Company: Decodable {
    let employeeCount: Int
    let yearFounded: Int
    let founder: String
    let launchSiteCount: Int
    let name: String
    let officers: Officers
    let testSiteCount: Int
    let valuation: Double
    let links: Links
    let headquarters: Headquarters
    let summary: String
}

extension Company {
    enum CodingKeys: String, CodingKey {
        case employeeCount = "employees"
        case yearFounded = "founded"
        case founder
        case ceo
        case coo
        case cto
        case ctoPropulsion = "cto_propulsion"
        case launchSiteCount = "launch_sites"
        case name
        case testSiteCount = "test_sites"
        case valuation
        case links
        case headquarters
        case summary
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
