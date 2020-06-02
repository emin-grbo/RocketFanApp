import Foundation

struct Links: Decodable {
    let article: URL?
    let elonTwitter: URL?
    let flickr: URL?
    let reddit: URL?
    let twitter: URL?
    let website: URL?
    let wikipedia: URL?
    let youtubeId: String?
    let missionPatchSmall: URL?

    init(article: URL? = nil,
         reddit: URL? = nil,
         wikipedia: URL? = nil,
         twitter: URL? = nil,
         website: URL? = nil,
         flickr: URL? = nil,
         elonTwitter: URL? = nil,
         youtubeId: String? = nil,
         missingPatchSmall: URL? = nil) {

        self.article = article
        self.reddit = reddit
        self.wikipedia = wikipedia
        self.twitter = twitter
        self.website = website
        self.flickr = flickr
        self.elonTwitter = elonTwitter
        self.youtubeId = youtubeId
        self.missionPatchSmall = missingPatchSmall
    }
}

extension Links {
    enum CodingKeys: String, CodingKey {
        case article
        case flickr
        case reddit
        case twitter
        case website
        case wikipedia
        case elonTwitter
        case youtubeId = "youtube_id"
        case missionPatchSmall = "mission_patch_small"
    }
}
