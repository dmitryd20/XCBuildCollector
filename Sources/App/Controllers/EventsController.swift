import Vapor

struct EventsController: RouteCollection {

    // MARK: -  Constants
    
    private enum Keys {
        static let routeGroup = "events"
        static let new = "new"
    }

    // MARK: - Private Properties

    private let eventsService: EventsService

    // MARK: - RouteCollection

    func boot(routes: RoutesBuilder) throws {
        let eventsRoutes = routes.grouped(.constant(Keys.routeGroup))
        eventsRoutes.post(.constant(Keys.new), use: postEvent)
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

}


