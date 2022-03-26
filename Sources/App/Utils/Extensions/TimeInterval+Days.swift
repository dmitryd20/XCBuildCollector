import Foundation

public extension TimeInterval {

    static func seconds(_ value: Int) -> TimeInterval {
        return Double(value)
    }

    static func minutes(_ value: Int) -> TimeInterval {
        return .seconds(value * 60)
    }

    static func hours(_ value: Int) -> TimeInterval {
        return minutes(value * 60)
    }

    static func days(_ value: Int) -> TimeInterval {
        return hours(value * 24)
    }

    static func weeks(_ value: Int) -> TimeInterval {
        return days(value * 7)
    }

}
