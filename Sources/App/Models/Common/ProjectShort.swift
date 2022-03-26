import Foundation
import Vapor

struct ProjectShort: Content {
    let name: String
    let averageBuildTime: TimeInterval?
}

extension Array where Element == ProjectShort {

    var projectsWithBuilds: Self {
        return self.filter { $0.averageBuildTime != nil }
    }

}
