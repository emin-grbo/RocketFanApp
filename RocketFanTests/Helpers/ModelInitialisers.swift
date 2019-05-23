import Foundation
@testable import RocketFan

/// A collection of custom initialisers that make writing tests easier!

extension Launch {
    init(details: String? = nil,
         failureDetails: FailureDetails? = nil,
         flightClub: URL? = nil,
         flightNumber: Int = 0,
         isTentative: Bool = false,
         launchDate: Date? = nil,
         launchWindow: Int? = nil,
         links: Links = Links(),
         missionId: [String] = [],
         missionName: String = "",
         rocket: Rocket = Rocket(),
         ships: [String] = [],
         site: Site = Site(),
         staticFireDate: Date? = nil,
         tentativeMaxPrecision: String = "",
         timeline: [String: Int?]? = nil) {

        self.details = details
        self.failureDetails = failureDetails
        self.flightClub = flightClub
        self.flightNumber = flightNumber
        self.isTentative = isTentative
        self.launchDate = launchDate
        self.launchWindow = launchWindow
        self.links = links
        self.missionId = missionId
        self.missionName = missionName
        self.rocket = rocket
        self.ships = ships
        self.site = site
        self.staticFireDate = staticFireDate
        self.tentativeMaxPrecision = tentativeMaxPrecision
        self.timeline = timeline
    }
}

extension Launch.Rocket {
    init() {
        self.init(fairings: nil, firstStage: [], id: "", name: "", secondStage: SecondStage(), type: "")
    }

    init(name: String) {

        self.init(fairings: nil,
                  firstStage: [],
                  id: "",
                  name: name,
                  secondStage: SecondStage(),
                  type: "")
    }
}

extension Launch.Rocket.SecondStage {
    init() {
        self.init(block: nil, payloads: [])
    }
}

extension Launch.Site {
    init() {
        self.init(id: "", shortName: "")
    }

    init(shortName: String) {
        self.init(id: "", shortName: shortName)
    }
}
