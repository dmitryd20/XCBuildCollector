import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

public func configure(_ app: Application) throws {
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "dmitry",
        password: Environment.get("DATABASE_PASSWORD") ?? "",
        database: Environment.get("DATABASE_NAME") ?? "xcbuildcollector"
    ), as: .psql)

    app.views.use(.leaf)

    // register routes
    try routes(app)
}
