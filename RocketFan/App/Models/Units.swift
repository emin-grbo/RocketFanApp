import Foundation

/// Describe a structure of metric and imperial units. Used to describe both Mass and Weight
struct Units {
    let kg: Int
    let lbs: Int

    init?(kg: Int?, lbs: Int?) {
        guard let kg = kg, let lbs = lbs else { return nil }

        self.kg = kg
        self.lbs = lbs
    }
}
