import Foundation
import Vapor

final class UsersService {

    // MARK: - Private Properties

    private let usersRepository: UsersRepository
    private let eventsRepository: EventsRepository

    // MARK: - Initialization

    init(usersRepository: UsersRepository,
         eventsRepository: EventsRepository) {
        self.usersRepository = usersRepository
        self.eventsRepository = eventsRepository
    }

    // MARK: - Internal Methods

    func getAverageBuildTimes(historyTimeLimit: TimeInterval? = nil) async throws -> [UserShort] {
        let users = try await usersRepository.getAllUsers()
        let buildTimes = try await users.concurrentMap { user -> UserShort in
            let averageBuildTime = try await self.eventsRepository.getAverageBuildTime(forUser: user.email, historyTimeLimit: historyTimeLimit)
            return UserShort(
                email: user.email,
                averageBuildTime: averageBuildTime
            )
        }
        return buildTimes
            .usersWithBuilds
            .sorted { $0.averageBuildTime! > $1.averageBuildTime! }
    }

}
