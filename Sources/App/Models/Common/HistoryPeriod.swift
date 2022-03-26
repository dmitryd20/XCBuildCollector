import Foundation

enum HistoryPeriod: String {
    case week
    case month
    case all
}

extension HistoryPeriod {

    var timeInterval: TimeInterval? {
        switch self {
        case .week:
            return .weeks(1)
        case .month:
            return .days(30)
        case .all:
            return nil
        }
    }

}
