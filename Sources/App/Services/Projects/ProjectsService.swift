import Foundation
import Vapor

final class ProjectsService {

    // MARK: - Private Properties

    private let projectsRepository: ProjectsRepository
    private let eventsRepository: EventsRepository

    // MARK: - Initialization

    init(projectsRepository: ProjectsRepository,
         eventsRepository: EventsRepository) {
        self.projectsRepository = projectsRepository
        self.eventsRepository = eventsRepository
    }

    // MARK: - Internal Methods

    func getAllProjectNames() async throws -> [String] {
        return try await projectsRepository.getAllProjects()
            .map(\.name)
    }

    func getAverageBuildTimes(historyTimeLimit: TimeInterval? = nil) async throws -> [ProjectShort] {
        let projects = try await projectsRepository.getAllProjects()
        let buildTimes = try await projects.concurrentMap { project -> ProjectShort in
            let averageBuildTime = try await self.eventsRepository.getAverageBuildTime(for: project.name, historyTimeLimit: historyTimeLimit)
            return ProjectShort(
                name: project.name,
                averageBuildTime: averageBuildTime
            )
        }
        return buildTimes
            .projectsWithBuilds
            .sorted { $0.averageBuildTime! > $1.averageBuildTime! }
    }

}
