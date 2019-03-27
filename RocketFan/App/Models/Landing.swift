import Foundation

struct Landing {
    let attempts: Int
    let successes: Int

    init?(attempts: Int?, successes: Int?) {
        guard let attempts = attempts, let successes = successes else { return nil }

        self.attempts = attempts
        self.successes = successes
    }
}
