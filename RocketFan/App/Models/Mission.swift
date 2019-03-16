import Foundation

struct Mission: Decodable {
    let description: String
    let id: String
    let links: Links
    let manufacturers: [String]
    let name: String
    let payloadIds: [String]
}

extension Mission {
    enum CodingKeys: String, CodingKey {
        case description
        case id = "mission_id"
        case manufacturers
        case name = "mission_name"
        case payloadIds = "payload_ids"
        case twitter
        case website
        case wikipedia
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        description = try container.decode(String.self, forKey: .description)
        id = try container.decode(String.self, forKey: .id)
        manufacturers = try container.decode(Array.self, forKey: .manufacturers)
        name = try container.decode(String.self, forKey: .name)
        payloadIds = try container.decode(Array.self, forKey: .payloadIds)

        let twitter = try container.decodeIfPresent(URL.self, forKey: .twitter)
        let website = try container.decodeIfPresent(URL.self, forKey: .website)
        let wikipedia = try container.decodeIfPresent(URL.self, forKey: .wikipedia)
        links = Links(wikipedia: wikipedia, twitter: twitter, website: website)
    }
}
