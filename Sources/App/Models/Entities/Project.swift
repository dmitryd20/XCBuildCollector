import Foundation
import Vapor
import Fluent

public final class Project: Model {

    // MARK: -  Constants

    enum Keys {
        static let schema = "projects"
        static let name = FieldKey(stringLiteral: "name")
    }

    public static var schema: String {
        Keys.schema
    }

    // MARK: - Properties

    @ID(custom: .id, generatedBy: .database)
    public var id: Int?

    @Field(key: Keys.name)
    public var name: String!

    // MARK: - Initialization

    public init() {}

    public init(id: Int? = nil,
                name: String) {
        self.id = id
        self.name = name
    }

}
