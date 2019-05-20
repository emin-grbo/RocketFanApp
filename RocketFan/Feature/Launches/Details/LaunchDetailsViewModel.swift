import Foundation

struct LaunchDetailsViewModel {
    var title: String {
        return launch.missionName
    }

    var flightNumber: String {
        return "Flight #\(launch.flightNumber)"
    }

    var description: String {
         return launch.details ?? "No launch details."
    }

    private let launch: Launch

    init(launch: Launch) {
        self.launch = launch
    }
}
