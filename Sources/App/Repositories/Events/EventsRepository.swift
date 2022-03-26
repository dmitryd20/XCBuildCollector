import Foundation

public protocol EventsRepository {
    func save(event: Event) async throws
    func getEvents(for projectName: String) async throws -> [Event]
    func getAverageBuildTime(for projectName: String, historyTimeLimit: TimeInterval?) async throws -> TimeInterval?
}

public extension EventsRepository {
    func getAverageBuildTime(for projectName: String) async throws -> TimeInterval? {
        return try await getAverageBuildTime(for: projectName, historyTimeLimit: nil)
    }
}
