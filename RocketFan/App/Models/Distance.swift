import Foundation

struct Distance: Decodable {
    let fromEarthKm: Double?
    let fromEarthMi: Double?
    let fromMarsKm: Double?
    let fromMarsMi: Double?

    init?(fromEarthKm: Double? = nil,
          fromEarthMi: Double? = nil,
          fromMarsKm: Double? = nil,
          fromMarsMi: Double? = nil) {

        if fromEarthKm == nil &&
            fromEarthMi == nil &&
            fromMarsKm == nil &&
            fromMarsMi == nil {
            return nil
        }

        self.fromEarthKm = fromEarthKm
        self.fromEarthMi = fromEarthMi
        self.fromMarsKm = fromMarsKm
        self.fromMarsMi = fromMarsMi
    }
}
