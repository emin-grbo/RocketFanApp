import XCTest

@testable
import RocketFan

class SettingsTests: XCTestCase {

    var userDefaults: UserDefaults!
    var settings: Settings!

    override func setUp() {
        super.setUp()

        userDefaults = UserDefaults(suiteName: #file)
        settings = Settings(with: userDefaults)
    }

    override func tearDown() {
        super.tearDown()

        userDefaults.removePersistentDomain(forName: #file)
    }

    func test_CanStore_UsesMetricSystemSetting() {
        XCTAssertNil(userDefaults.object(forKey: Settings.Keys.usesMetricSystem.rawValue))

        settings.usesMetricSystem = true

        XCTAssertTrue(userDefaults.bool(forKey: Settings.Keys.usesMetricSystem.rawValue))
    }

    func test_CanRead_UsesMetricSystemSetting() {
        XCTAssertNil(userDefaults.object(forKey: Settings.Keys.usesMetricSystem.rawValue))
        userDefaults.set(true, forKey: Settings.Keys.usesMetricSystem.rawValue)

        XCTAssertEqual(settings.usesMetricSystem, true)
    }

    func test_CanPrepopulateDefaults_UsingLocale() {
        XCTAssertNil(userDefaults.object(forKey: Settings.Keys.usesMetricSystem.rawValue))
        let locale = Locale(identifier: "en_GB")

        settings.setupDefaultValues(using: locale)

        XCTAssertEqual(userDefaults.bool(forKey: Settings.Keys.usesMetricSystem.rawValue), locale.usesMetricSystem)
    }

}
