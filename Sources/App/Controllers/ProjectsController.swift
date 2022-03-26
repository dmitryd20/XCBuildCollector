import Vapor

struct ProjectsController: RouteCollection {

    // MARK: -  Constants
    
    private enum Keys {
        static let routeGroup = "projects"
        static let average = "average"
        static let period = "period"
    }

    // MARK: - Private Properties

    private let projectsService: ProjectsService

    // MARK: - RouteCollection

    func boot(routes: RoutesBuilder) throws {
        let projectsRoutes = routes.grouped(.constant(Keys.routeGroup))
        projectsRoutes.get(.constant(Keys.average), .parameter(Keys.period), use: getAverageBuildTimes)
    }

    init(app: Application) {
        self.projectsService = ProjectsService.build(for: app)
    }

}

// MARK: - Requests

private extension ProjectsController {

    func getAverageBuildTimes(with request: Request) async throws -> ProjectsBuildTimes {
        let periodName = request.parameters.get(Keys.period)
        let period = periodName.map { HistoryPeriod(rawValue: $0) }
        let buildTimes = try await projectsService.getAverageBuildTimes(historyTimeLimit: period??.timeInterval)
        return ProjectsBuildTimes(buildTimes: buildTimes)
    }

}
