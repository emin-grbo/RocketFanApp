import XCTest
@testable import RocketFan

class HistoryTests: XCTestCase {
    var history: History?

    override func setUp() {
        guard let data = JSONLoader.load(.history) else {
            XCTFail("Missing file: History.json")
            return
        }

        do {

            let decoder = JSONDecoder(dateDecodingStrategy: .secondsSince1970)
            let histories = try decoder.decoded([History].self, from: data)
            history = histories.first

        } catch {
            XCTFail("Decoding failed: \(error)")
        }

    }

    func test_RequiredValues_CanBeDecoded_FromJSON() {
        XCTAssertNotNil(history)
    }

    func test_OptionalValues_CanBeDecoded_IfExists() {
        XCTAssertEqual(history?.flightNumber, 41)
    }

    func test_LinksModel_CanBeDecoded() {
        let links = history?.links

        // swiftlint:disable:next line_length
        let article = "https://spaceflightnow.com/2017/06/03/reused-dragon-cargo-capsule-launched-on-journey-to-space-station/"
        XCTAssertEqual(links?.article.absoluteString, article)

        let reddit = "https://www.reddit.com/r/spacex/comments/6ektkt/welcome_to_the_rspacex_crs11_official_launch/"
        XCTAssertEqual(links?.reddit?.absoluteString, reddit)

        let wiki = "https://en.wikipedia.org/wiki/SpaceX_CRS-11"
        XCTAssertEqual(links?.wikipedia?.absoluteString, wiki)
    }
}
