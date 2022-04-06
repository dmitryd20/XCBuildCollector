import Foundation

public protocol EventsRepository {
    func save(event: Event) async throws
    func getEvents(for projectName: String, historyTimeLimit: TimeInterval?) async throws -> [Event]
    func getAverageBuildTime(for projectName: String, historyTimeLimit: TimeInterval?) async throws -> TimeInterval?
    func getAverageBuildTime(forUser email: String, historyTimeLimit: TimeInterval?) async throws -> TimeInterval?
}
