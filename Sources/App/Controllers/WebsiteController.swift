import Vapor
import Leaf

struct WebsiteController: RouteCollection {

    // MARK: -  Constants

    private enum Keys {
        static let routeGroup = "plots"
        static let allProjects = "all_projects"
        static let projectHistory = "project_history"
    }

    // MARK: - Private Properties

    private let projectsService: ProjectsService
    private let eventsService: EventsService

    // MARK: - RouteCollection

    func boot(routes: RoutesBuilder) throws {
        routes.get(use: showHomePage)

        let plotsRoutes = routes.grouped(.constant(Keys.routeGroup))
        plotsRoutes.get(.constant(Keys.allProjects), use: showAllProjects)
        plotsRoutes.get(.constant(Keys.projectHistory), use: showProjectHistory)
    }

    init(app: Application) {
        self.projectsService = ProjectsService.build(for: app)
        self.eventsService = EventsService.build(for: app)
    }

}

// MARK: - Requests

private extension WebsiteController {

    func showHomePage(_ request: Request) async throws -> View {
        let context = BasePage(pageInfo: .init(title: "XCBuildCollector"))
        return try await request.view.render("index", context)
    }

    func showAllProjects(_ request: Request) async throws -> View {
        let context = BasePage(pageInfo: .init(title: "Average build durations"))
        return try await request.view.render("projects_average", context)
    }

    func showProjectHistory(_ request: Request) async throws -> View {
        let projectNames = try await projectsService.getAllProjectNames()
        let context = ProjectPage(
            pageInfo: .init(title: "Project builds history"),
            projectNames: projectNames
        )
        return try await request.view.render("project_history", context)
    }

}
