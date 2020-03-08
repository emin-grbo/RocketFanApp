import Foundation

struct LaunchDetailsViewModel {
    var title: String {
        return launch.missionName
    }

    var date: String {
        guard let date = launch.launchDate else { return "TBC" }

        return dateFormatter.string(from: date)
    }

    var flightNumber: String {
        return "Flight #\(launch.flightNumber)"
    }

    var description: String {
         return launch.details ?? "No launch details."
    }

    private let launch: Launch
    private let dateFormatter = DateFormatter()

    init(launch: Launch) {
        self.launch = launch

        let precision = DateFormatter.Precision(rawValue: launch.tentativeMaxPrecision ?? "hour")
        dateFormatter.setPrecision(precision)
    }
}
