import Foundation

extension Date {

    static var today: Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: .now)
        return Calendar.current.date(from: components)!
    }

}
