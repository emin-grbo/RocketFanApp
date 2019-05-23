import Foundation

struct LaunchCellViewModel {
    private let launch: Launch
    private let dateFormatter: DateFormatter

    init(with launch: Launch,
         _ dateFormatter: DateFormatter) {

        self.launch = launch
        self.dateFormatter = dateFormatter
        self.dateFormatter.setPrecision(.hour)
    }
}

extension LaunchCellViewModel {
    var missionName: String {
        return launch.missionName
    }

    var launchDate: String {
        guard let date = launch.launchDate else { return "TBC" }

        return dateFormatter.string(from: date)
    }

    var siteShortName: String {
        return launch.site.shortName
    }

    var rocketName: String {
        return launch.rocket.name
    }
}
