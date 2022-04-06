import Foundation

public protocol UsersRepository {
    func getAllUsers() async throws -> [User]
}
