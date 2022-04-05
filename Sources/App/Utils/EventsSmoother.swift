import Foundation

class EventsSmoother {

    // MARK: - Properties

    private let events: [EventShort]
    private let windowSize: TimeInterval

    // MARK: - Pointers

    private var left = 0
    private var current = 0
    private var right = 0

    // MARK: - Results

    private var windowSum: TimeInterval = 0

    private var averageValue: TimeInterval {
        return windowSum / Double(itemsInWindow)
    }

    // MARK: - Boundary events

    private var earliestEvent: EventShort {
        events[left]
    }

    private var currentEvent: EventShort {
        events[current]
    }

    private var latestEvent: EventShort {
        events[right]
    }

    // MARK: - Distances

    private var distanceToLeft: TimeInterval {
        return .from(milliseconds: currentEvent.startTime - earliestEvent.startTime)
    }

    private var distanceToRight: TimeInterval {
        return .from(milliseconds: latestEvent.startTime - currentEvent.startTime)
    }

    private var itemsInWindow: Int {
        return right - left + 1
    }

    // MARK: - Conditions

    private var needMoveLeft: Bool {
        return distanceToLeft > windowSize
    }

    private var needMoveRight: Bool {
        return distanceToRight < windowSize
    }

    private var canMoveRight: Bool {
        return right + 1 < events.count
    }

    // MARK: - Initialization

    init(events: [EventShort], windowSize: TimeInterval) {
        self.events = events
        self.windowSize = windowSize
    }

    // MARK: - Internal Methods

    func smoothEvents() -> [EventShort] {
        var smoothedEvents: [EventShort] = []
        for event in events {
            while needMoveLeft {
                if left > 0 {
                    windowSum -= events[left - 1].duration
                }
                left += 1
            }
            while needMoveRight && canMoveRight {
                windowSum += latestEvent.duration
                right += 1
            }
            smoothedEvents.append(EventShort(
                startTime: event.startTime,
                duration: averageValue.truncated())
            )
            current += 1
        }
        return smoothedEvents
    }

}
