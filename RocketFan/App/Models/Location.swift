import Foundation

struct Location: Decodable {
    let latitude: Double
    let longitude: Double
    let name: String?
    let region: String?
}
