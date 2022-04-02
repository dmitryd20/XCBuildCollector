import Vapor

struct EventsController: RouteCollection {

    // MARK: -  Constants
    
    private enum Keys {
        static let routeGroup = "events"
        static let new = "new"
        static let project = "project"
        static let name = "name"
    }

    // MARK: - Private Properties

    private let eventsService: EventsService

    // MARK: - RouteCollection

    func boot(routes: RoutesBuilder) throws {
        let eventsRoutes = routes.grouped(.constant(Keys.routeGroup))
        eventsRoutes.post(.constant(Keys.new), use: postEvent)
        eventsRoutes.get(.constant(Keys.project), .parameter(Keys.name), use: getEventsForProject)
    }

    init(app: Application) {
        self.eventsService = EventsService.build(for: app)
    }

}

// MARK: - Requests

private extension EventsController {

    func postEvent(with request: Request) async throws -> EmptyResponse {
        let newEventRequest = try request.content.decode(Event.CreateRequest.self)
        try await eventsService.createEvent(model: newEventRequest)
        return EmptyResponse()
    }

    func getEventsForProject(with request: Request) async throws -> EventsList {
        guard let projectName = request.parameters.get(Keys.name) else {
            throw Abort(.badRequest)
        }
        let events = try await eventsService.getShortEvents(for: projectName)
        return EventsList(events: EventsSmoother(events: events, windowSize: .days(3)).smoothEvents())
    }

}
