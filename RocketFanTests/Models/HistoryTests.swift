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
            history = histories[11]

        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    func test_RequiredValues_CanBeDecoded_FromJSON() {
        XCTAssertNotNil(history)
    }

    func test_OptionalValues_CanBeDecoded_IfExists() {
        XCTAssertEqual(history?.flightNumber, 19)
    }

    func test_LinksModel_CanBeDecoded() {
        let links = history?.links

        // swiftlint:disable:next line_length
        let article = "https://spaceflightnow.com/2015/01/10/dragon-successfully-launched-rocket-recovery-demo-crash-lands/"
        XCTAssertEqual(links?.article?.absoluteString, article)

        let reddit = "http://www.reddit.com/r/spacex/comments/2rrdha"
        XCTAssertEqual(links?.reddit?.absoluteString, reddit)

        let wiki = "https://en.wikipedia.org/wiki/SpaceX_CRS-5"
        XCTAssertEqual(links?.wikipedia?.absoluteString, wiki)
    }
}
