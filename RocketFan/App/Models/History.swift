import Foundation

struct History: Decodable {
    let details: String
    let eventDate: Date
    let flightNumber: Int?
    let id: Int
    let links: Links
    let title: String
}

extension History {
    enum CodingKeys: String, CodingKey {
        case details
        case eventDate = "event_date_unix"
        case flightNumber = "flight_number"
        case id
        case links
        case title
    }
}
