import Vapor

extension ProjectsService {

    static func build(for app: Application) -> ProjectsService {
        return ProjectsService(
            projectsRepository: ProjectsDatabaseRepository(database: app.db),
            eventsRepository: EventsDatabaseRepository(database: app.db)
        )
    }

}

