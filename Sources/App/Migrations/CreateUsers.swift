import Fluent

struct CreateUsers: Migration {

    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(User.schema)
            .field(.id, .int, .identifier(auto: true))
            .field(User.Keys.email, .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(User.schema)
            .delete()
    }
}
