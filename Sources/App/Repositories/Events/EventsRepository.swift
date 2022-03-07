import Foundation

public protocol EventsRepository {
    func save(event: Event) async throws

}
