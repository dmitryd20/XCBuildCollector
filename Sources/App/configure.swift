import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

public func configure(_ app: Application) throws {
    // register database
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "dmitry",
        password: Environment.get("DATABASE_PASSWORD") ?? "",
        database: Environment.get("DATABASE_NAME") ?? "xcbuildcollector"
    ), as: .psql)

    // register migrations
    app.migrations.add(CreateProjects())
    app.migrations.add(CreateUsers())
    app.migrations.add(CreateEvents())

    // register files
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register views
    app.views.use(.leaf)

    // register routes
    try routes(app)
}
