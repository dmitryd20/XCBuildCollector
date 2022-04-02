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

    func getEvents(for projectName: String, historyTimeLimit: TimeInterval?) async throws -> [Event] {
        let startDay = getStartDay(for: historyTimeLimit)
        return try await Event.query(on: database)
            .filter(\.$project == projectName)
            .filter(\.$startTime >= startDay)
            .sort(Event.Keys.startTime)
            .all()
    }

    func getAverageBuildTime(for projectName: String, historyTimeLimit: TimeInterval?) async throws -> TimeInterval? {
        let startDay = getStartDay(for: historyTimeLimit)
        return try await Event.query(on: database)
            .filter(\.$project == projectName)
            .filter(\.$startTime >= startDay)
            .average(\.$duration)?
            .truncated()
    }

}

// MARK: - Private Methods

private extension EventsDatabaseRepository {

    func getStartDay(for historyTimeLimit: TimeInterval?) -> Date {
        return historyTimeLimit.map { Date.today.advanced(by: -$0) } ?? .distantPast
    }

}
