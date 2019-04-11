import Foundation

struct Settings {
    var usesMetricSystem: Bool {
        get { return defaults.bool(forKey: Keys.usesMetricSystem.rawValue) }
        set { defaults.set(newValue, forKey: Keys.usesMetricSystem.rawValue) }
    }

    private let defaults: UserDefaults

    init(with defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func setupDefaultValues(using locale: Locale = .current) {
        let key = Keys.usesMetricSystem.rawValue
        if defaults.object(forKey: key) == nil {
            defaults.set(locale.usesMetricSystem, forKey: key)
        }
    }
}

extension Settings {
    enum Keys: String {
        case usesMetricSystem
    }
}
