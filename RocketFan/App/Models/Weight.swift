import Foundation

struct Weight {
    let kg: Int
    let lbs: Int

    init?(kg: Int?, lbs: Int?) {
        guard let kg = kg, let lbs = lbs else { return nil }

        self.kg = kg
        self.lbs = lbs
    }
}
