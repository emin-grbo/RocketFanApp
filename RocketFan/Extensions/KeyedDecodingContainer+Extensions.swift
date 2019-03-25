import Foundation

extension KeyedDecodingContainer {
    enum Keys: String, CodingKey {
        // Weight
        case kg
        case lb

        // Distance
        case meters
        case feet

        // Force
        case kn = "kN"
        case lbf

        // Volume
        case cubicMeters = "cubic_meters"
        case cubicFeet = "cubic_feet"
    }

    func decodeDistanceUnits(for containerKey: KeyedDecodingContainer.Key) throws -> Units {
        return try decodeUnits(containerKey: containerKey, metricKey: .meters, imperialKey: .feet)
    }

    func decodeForceUnits(for containerKey: KeyedDecodingContainer.Key) throws -> Units {
        return try decodeUnits(containerKey: containerKey, metricKey: .kn, imperialKey: .lbf)
    }

    func decodeMassUnits(for containerKey: KeyedDecodingContainer.Key) throws -> Units {
        return try decodeUnits(containerKey: containerKey, metricKey: .kg, imperialKey: .lb)
    }

    func decodeWeightUnits(for containerKey: KeyedDecodingContainer.Key) throws -> Units {
        return try decodeMassUnits(for: containerKey)
    }

    func decodeVolumeUnits(for containerKey: KeyedDecodingContainer.Key) throws -> Units {
        return try decodeUnits(containerKey: containerKey, metricKey: .cubicMeters, imperialKey: .cubicFeet)
    }

    private func decodeUnits(containerKey: KeyedDecodingContainer.Key,
                             metricKey: Keys,
                             imperialKey: Keys) throws -> Units {
        let nestedContainer = try self.nestedContainer(keyedBy: Keys.self, forKey: containerKey)
        let metric: Double = try nestedContainer.decode(Double.self, forKey: metricKey)
        let imperial: Double = try nestedContainer.decode(Double.self, forKey: imperialKey)
        return Units(metric: metric, imperial: imperial)!
    }
}
