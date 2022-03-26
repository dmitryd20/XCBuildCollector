import Vapor

struct ProjectsBuildTimes: Content {
    let buildTimes: [ProjectShort]
}

extension ProjectsBuildTimes {

    static var empty: ProjectsBuildTimes {
        return .init(buildTimes: [])
    }

}
