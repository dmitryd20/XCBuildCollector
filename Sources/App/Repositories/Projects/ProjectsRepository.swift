import Foundation

public protocol ProjectsRepository {
    func getAllProjects() async throws -> [Project]
}
