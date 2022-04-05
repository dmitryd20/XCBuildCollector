import Foundation

struct ProjectPage: Encodable {
    let pageInfo: PageInfo
    let projectNames: [String]
}
