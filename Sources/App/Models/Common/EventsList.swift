import Foundation
import Vapor

struct EventsList: Content {
    let events: [EventShort]
}
