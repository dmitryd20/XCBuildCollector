import Fluent

struct CreateEvents: Migration {

    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Event.schema)
            .field(.id, .int, .identifier(auto: true))
            .field(Event.Keys.user, .string, .required)
            .field(Event.Keys.hardware, .string, .required)
            .field(Event.Keys.project, .string, .required)
            .field(Event.Keys.startTime, .datetime, .required)
            .field(Event.Keys.duration, .double, .required)
            .field(Event.Keys.isSuccessful, .bool, .required)
            .field(Event.Keys.isIncremental, .bool)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Event.schema)
            .delete()
    }
}
