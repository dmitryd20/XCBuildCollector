import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: EventsController(app: app))
    try app.register(collection: ProjectsController(app: app))
    try app.register(collection: WebsiteController(app: app))
}
