import Foundation

struct Landings {
    let attempted: Int
    let successful: Int

    init?(attempted: Int?, successful: Int?) {
        guard let attempted = attempted, let successful = successful else { return nil }

        self.attempted = attempted
        self.successful = successful
    }
}
