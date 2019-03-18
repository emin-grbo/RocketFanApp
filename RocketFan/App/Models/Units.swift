import Foundation

/// Describe a structure of metric and imperial units.
struct Units: Decodable {
    let metric: Double
    let imperial: Double

    init?(metric: Double?, imperial: Double?) {
        guard let metric = metric, let imperial = imperial else { return nil }

        self.metric = metric
        self.imperial = imperial
    }
}
