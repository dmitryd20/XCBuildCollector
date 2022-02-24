import Foundation
import Vapor
import Fluent

public final class User: Model {

    // MARK: -  Constants

    enum Keys {
        static let schema = "users"
        static let email = FieldKey(stringLiteral: "email")
    }

    public static var schema: String {
        Keys.schema
    }

    // MARK: - Properties

    @ID(custom: .id, generatedBy: .database)
    public var id: Int?

    @Field(key: Keys.email)
    public var email: String!

    // MARK: - Initialization

    public init() {}

    public init(id: Int? = nil,
                email: String) {
        self.id = id
        self.email = email
    }

}
