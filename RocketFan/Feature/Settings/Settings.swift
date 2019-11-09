import Foundation

final class Settings {
    private let defaults: Persistable

    init(with defaults: Persistable) {
        self.defaults = defaults
        setupInitialValues()
    }
}

// MARK: - Public computed Variables
extension Settings {
    var weightUnit: MeasurementSystem {
        get {
            let key = defaults.integer(forKey: Keys.weight.rawValue)
            return MeasurementSystem(rawValue: key) ?? .metric
        }
        
        set { defaults.set(newValue.rawValue, forKey: Keys.weight.rawValue) }
    }

    var distanceUnit: MeasurementSystem {
        get {
            let key = defaults.integer(forKey: Keys.distance.rawValue)
            return MeasurementSystem(rawValue: key) ?? .metric
        }

        set { defaults.set(newValue.rawValue, forKey: Keys.distance.rawValue) }
    }

    var weightUnitDisplayName: String {
        weightUnit == .metric ? "kg" : "lb"
    }

    var distanceUnitDisplayName: String {
        distanceUnit == .metric ? "km" : "mi"
    }

    var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString" as String] as? String ?? ""
    }

    var appBuildNumber: String {
        return Bundle.main.infoDictionary?["CFBundleVersion" as String] as? String ?? ""
    }
}

// MARK: - Private extension
private extension Settings {
    private enum Keys: String {
        case weight = "weightUnits"
        case distance = "distanceUnits"
    }

    private var localeUsesMetric: Bool {
        Locale.current.usesMetricSystem
    }

    private func setupInitialValues() {
        weightUnit = localeUsesMetric ? .metric : .imperial
        distanceUnit = localeUsesMetric ? .metric : .imperial
    }
}
