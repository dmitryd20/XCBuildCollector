import Foundation
import Vapor

struct UserShort: Content {
    let email: String
    let averageBuildTime: TimeInterval?
}

extension Array where Element == UserShort {

    var usersWithBuilds: Self {
        return self.filter { $0.averageBuildTime != nil }
    }

}
