import XCTest

@testable
import RocketFan

class DateFormatterExtensionsTests: XCTestCase {
    let date = Date(timeIntervalSince1970: 1569861934) // 30 Sep 2019, 16:45:34 GMT
    var dateFormatter: DateFormatter!

    override func setUp() {
        super.setUp()

        dateFormatter = DateFormatter()
        // Use a specific locale so we can test string output
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")!
    }

    func test_Precision_Hour_ReturnsExpectedString() {
        dateFormatter.setPrecision(.hour)

        let dateString = dateFormatter.string(from: date)

        XCTAssertEqual(dateString, "30 Sep 2019, 16:45:34")
    }

    func test_Precision_Day_ReturnsExpectedString() {
        dateFormatter.setPrecision(.day)

        let dateString = dateFormatter.string(from: date)

        XCTAssertEqual(dateString, "30 Sep 2019")
    }

    func test_Precision_Month_ReturnsExpectedString() {
        dateFormatter.setPrecision(.month)

        let dateString = dateFormatter.string(from: date)

        XCTAssertEqual(dateString, "Sep 2019")
    }

    func test_Precision_Quarter_ReturnsExpectedString() {
        dateFormatter.setPrecision(.quarter)

        let dateString = dateFormatter.string(from: date)

        XCTAssertEqual(dateString, "Q3 2019")
    }

    func test_Precision_Half_ReturnsExpectedString() {
        dateFormatter.setPrecision(.half)

        let dateString = dateFormatter.string(from: date)

        XCTAssertEqual(dateString, "Q3 2019")
    }

    func test_Precision_Year_ReturnsExpectedString() {
        dateFormatter.setPrecision(.year)

        let dateString = dateFormatter.string(from: date)

        XCTAssertEqual(dateString, "2019")
    }
}
