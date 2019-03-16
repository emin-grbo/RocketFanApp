import Foundation

struct ApiInfo: Decodable {
    let description: String
    let docsLink: URL
    let link: URL
    let name: String
    let organizationLink: URL
    let redditSub: String
    let version: String
}

extension ApiInfo {
    enum CodingKeys: String, CodingKey {
        case description
        case docsLink = "docs"
        case link = "project_link"
        case name = "project_name"
        case organizationLink = "organization_link"
        case redditSub = "organization"
        case version
    }
}
