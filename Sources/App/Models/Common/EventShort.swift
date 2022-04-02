import Foundation
import Vapor

struct EventShort: Content {
    let startTime: Int
    let duration: TimeInterval
}

extension Event {

    var short: EventShort {
        return .init(
            startTime: startTime.timeIntervalSince1970.toMilliseconds(),
            duration: duration
        )
    }

}
