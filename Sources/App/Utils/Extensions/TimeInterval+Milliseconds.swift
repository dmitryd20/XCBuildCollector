import Foundation

extension TimeInterval {

    static func from(milliseconds: Int) -> TimeInterval {
        return Double(milliseconds) / 1000.0
    }

    func toMilliseconds() -> Int {
        return Int(self * 1000)
    }

}
