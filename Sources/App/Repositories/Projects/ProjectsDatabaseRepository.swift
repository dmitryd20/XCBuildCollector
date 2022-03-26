import Fluent

final class ProjectsDatabaseRepository: ProjectsRepository {

    // MARK: - Private Properties

    private let database: Database

    // MARK: - Initialization

    init(database: Database) {
        self.database = database
    }

    // MARK: - ProjectsRepository

    func getAllProjects() async throws -> [Project] {
        return try await Project.query(on: database)
            .sort(Project.Keys.name)
            .all()
    }

    func save(event: Event) async throws {
        try await event.save(on: database)
    }

}

