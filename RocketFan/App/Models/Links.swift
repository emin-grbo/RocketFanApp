import Foundation

struct Links: Decodable {
    let article: URL?
    let reddit: URL?
    let twitter: URL?
    let website: URL?
    let wikipedia: URL?

    init(article: URL? = nil,
         reddit: URL? = nil,
         wikipedia: URL? = nil,
         twitter: URL? = nil,
         website: URL? = nil) {

        self.article = article
        self.reddit = reddit
        self.wikipedia = wikipedia
        self.twitter = twitter
        self.website = website
    }
}
