import Foundation
import Vapor

final class EventsService {

    // MARK: - Private Properties

    private let eventsRepository: EventsRepository

    // MARK: - Initialization

    init(eventsRepository: EventsRepository) {
        self.eventsRepository = eventsRepository
    }

    // MARK: - Internal Methods

    func getShortEvents(for projectName: String, historyTimeLimit: TimeInterval? = nil) async throws -> [EventShort] {
        return try await eventsRepository.getEvents(for: projectName, historyTimeLimit: historyTimeLimit)
            .concurrentMap(\.short)
    }

    func createEvent(model: Event.CreateRequest) async throws {
        let event = Event(user: model.user,
                          hardware: model.device,
                          project: model.project,
                          startTime: Date(timeIntervalSince1970: .from(milliseconds: model.started)),
                          duration: .from(milliseconds: model.duration),
                          isSuccessful: model.is_successful,
                          isIncremental: model.is_incremental)
        try await eventsRepository.save(event: event)
    }

}
