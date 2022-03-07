import Vapor

extension EventsService {

    static func build(for app: Application) -> EventsService {
        return EventsService(eventsRepository: EventsDatabaseRepository(database: app.db))
    }

}

