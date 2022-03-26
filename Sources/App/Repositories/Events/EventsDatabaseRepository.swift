import Foundation
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

    func getEvents(for projectName: String) async throws -> [Event] {
        return try await Event.query(on: database)
            .filter(\.$project == projectName)
            .sort(Event.Keys.startTime)
            .all()
    }

    func getAverageBuildTime(for projectName: String, historyTimeLimit: TimeInterval?) async throws -> TimeInterval? {
        let startDay = historyTimeLimit.map { Date.today.advanced(by: -$0) } ?? .distantPast
        return try await Event.query(on: database)
            .filter(\.$project == projectName)
            .filter(\.$startTime >= startDay)
            .average(\.$duration)?
            .truncated()
    }

}
