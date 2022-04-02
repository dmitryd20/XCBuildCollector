import Foundation

public protocol EventsRepository {
    func save(event: Event) async throws
    func getEvents(for projectName: String, historyTimeLimit: TimeInterval?) async throws -> [Event]
    func getAverageBuildTime(for projectName: String, historyTimeLimit: TimeInterval?) async throws -> TimeInterval?
}

public extension EventsRepository {

    func getEvents(for projectName: String) async throws -> [Event] {
        return try await getEvents(for: projectName, historyTimeLimit: nil)
    }

    func getAverageBuildTime(for projectName: String) async throws -> TimeInterval? {
        return try await getAverageBuildTime(for: projectName, historyTimeLimit: nil)
    }

}
