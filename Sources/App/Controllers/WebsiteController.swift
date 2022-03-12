import Vapor
import Leaf

struct WebsiteController: RouteCollection {

    // MARK: -  Constants

    private enum Keys {
        static let routeGroup = "plots"
        static let allProjects = "all_projects"
    }

    // MARK: - Private Properties

    private let eventsService: EventsService

    // MARK: - RouteCollection

    func boot(routes: RoutesBuilder) throws {
        routes.get(use: indexHandler)
        let plotsRoutes = routes.grouped(.constant(Keys.routeGroup))
        plotsRoutes.get(.constant(Keys.allProjects), use: showAllProjects)
    }

    init(app: Application) {
        self.eventsService = EventsService.build(for: app)
    }

}

// MARK: - Requests

private extension WebsiteController {

    func indexHandler(_ request: Request) async throws -> View {
        let context = Page(title: "XCBuildCollector")
        return try await request.view.render("index", context)
    }

    func showAllProjects(_ request: Request) async throws -> View {
        let context = Page(title: "XCBuildCollector")
        return try await request.view.render("plot", context)
    }

}
