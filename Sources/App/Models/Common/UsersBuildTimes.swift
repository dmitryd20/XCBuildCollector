import Vapor

struct UsersBuildTimes: Content {
    let buildTimes: [UserShort]
}

extension UsersBuildTimes {

    static var empty: UsersBuildTimes {
        return .init(buildTimes: [])
    }

}
