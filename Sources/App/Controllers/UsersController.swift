import Vapor

struct UsersController: RouteCollection {

    // MARK: -  Constants
    
    private enum Keys {
        static let routeGroup = "users"
        static let average = "average"
        static let period = "period"
    }

    // MARK: - Private Properties

    private let usersService: UsersService

    // MARK: - RouteCollection

    func boot(routes: RoutesBuilder) throws {
        let usersRoutes = routes.grouped(.constant(Keys.routeGroup))
        usersRoutes.get(.constant(Keys.average), .parameter(Keys.period), use: getAverageBuildTimes)
    }

    init(app: Application) {
        self.usersService = UsersService.build(for: app)
    }

}

// MARK: - Requests

private extension UsersController {

    func getAverageBuildTimes(with request: Request) async throws -> UsersBuildTimes {
        let periodName = request.parameters.get(Keys.period)
        let period = periodName.map { HistoryPeriod(rawValue: $0) }
        let buildTimes = try await usersService.getAverageBuildTimes(historyTimeLimit: period??.timeInterval)
        return UsersBuildTimes(buildTimes: buildTimes)
    }

}
