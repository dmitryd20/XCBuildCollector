import Fluent

final class EventsDatabaseRepository: EventsRepository {

    // MARK: - Private Properties

    private let database: Database

    // MARK: - Initialization

    init(database: Database) {
        self.database = database
    }

    // MARK: - EventsRepository

    func save(event: Event) async throws {
        try await event.save(on: database)
    }

}
