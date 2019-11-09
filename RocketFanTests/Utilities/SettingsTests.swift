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

    func test_WeightUnitDisplayName_CorrectWhenMetric() {
        settings.weightUnit = .metric

        XCTAssertEqual(settings.weightUnitDisplayName, "kg")
    }

    func test_WeightUnitDisplayName_CorrectWhenImperial() {
        settings.weightUnit = .imperial

         XCTAssertEqual(settings.weightUnitDisplayName, "lb")
     }

    func test_DistanceUnitDisplayName_CorrectWhenMetric() {
        settings.distanceUnit = .metric

        XCTAssertEqual(settings.distanceUnitDisplayName, "km")
    }

    func test_DistanceUnitDisplayName_CorrectWhenImperial() {
        settings.weightUnit = .imperial

         XCTAssertEqual(settings.distanceUnitDisplayName, "mi")
     }
}
