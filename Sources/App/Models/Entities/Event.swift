import Foundation
import Vapor
import Fluent

public final class Event: Model {

    // MARK: -  Constants

    enum Keys {
        static let schema = "events"
        static let user = FieldKey(stringLiteral: "user")
        static let hardware = FieldKey(stringLiteral: "hardware")
        static let project = FieldKey(stringLiteral: "project")
        static let startTime = FieldKey(stringLiteral: "start_time")
        static let duration = FieldKey(stringLiteral: "duration")
        static let isSuccessful = FieldKey(stringLiteral: "is_successful")
        static let isIncremental = FieldKey(stringLiteral: "is_incremental")
    }

    public static var schema: String {
        Keys.schema
    }

    // MARK: - Properties

    @ID(custom: .id, generatedBy: .database)
    public var id: Int?

    @Field(key: Keys.user)
    var user: String!

    @Field(key: Keys.hardware)
    var hardware: String!

    @Field(key: Keys.project)
    var project: String!

    @Field(key: Keys.startTime)
    var startTime: Date!

    @Field(key: Keys.duration)
    var duration: TimeInterval!

    @Field(key: Keys.isSuccessful)
    var isSuccessful: Bool!

    @Field(key: Keys.isIncremental)
    var isIncremental: Bool?

    // MARK: - Initialization

    public init() {}

    public init(id: Int? = nil,
         user: String,
         hardware: String,
         project: String,
         startTime: Date,
         duration: TimeInterval,
         isSuccessful: Bool,
         isIncremental: Bool?) {
        self.id = id
        self.user = user
        self.hardware = hardware
        self.project = project
        self.startTime = startTime
        self.duration = duration
        self.isSuccessful = isSuccessful
        self.isIncremental = isIncremental
    }

}
