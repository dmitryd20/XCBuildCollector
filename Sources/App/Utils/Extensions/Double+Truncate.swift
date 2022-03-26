import Foundation

extension Double {
    func truncated(signs: Int = 3) -> Double {
        let multiplier = pow(10.0, Double(signs))
        return (self * multiplier).rounded() / multiplier
    }
}
