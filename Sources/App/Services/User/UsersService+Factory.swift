import Vapor

extension UsersService {

    static func build(for app: Application) -> UsersService {
        return UsersService(
            usersRepository: UsersDatabaseRepository(database: app.db),
            eventsRepository: EventsDatabaseRepository(database: app.db)
        )
    }

}

