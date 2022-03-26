import Foundation

extension TimeInterval {

    static func from(milliseconds: Int) -> TimeInterval {
        return Double(milliseconds) / 1000.0
    }

}
