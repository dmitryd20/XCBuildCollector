import Fluent

final class UsersDatabaseRepository: UsersRepository {

    // MARK: - Private Properties

    private let database: Database

    // MARK: - Initialization

    init(database: Database) {
        self.database = database
    }

    // MARK: - ProjectsRepository

    func getAllUsers() async throws -> [User] {
        return try await User.query(on: database)
            .sort(User.Keys.email)
            .all()
    }

}

