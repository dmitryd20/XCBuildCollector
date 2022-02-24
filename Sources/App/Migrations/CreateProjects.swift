import Fluent

struct CreateProjects: Migration {

    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Project.schema)
            .field(.id, .int, .identifier(auto: true))
            .field(Project.Keys.name, .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Project.schema)
            .delete()
    }
}
