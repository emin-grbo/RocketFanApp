import Foundation

struct SearchEngine {
    private let launches: [Launch]

    init(with launches: [Launch]) {
        self.launches = launches
    }
}

extension SearchEngine {
    func launches(before date: Date, withMissionName missionName: String = "") -> [Launch] {
        let validLaunches = launches.filter { $0.launchDate != nil }
        return validLaunches.filter { $0.launchDate! < date && partialMatches($0.missionName, with: missionName) }
    }

    func launches(after date: Date, withMissionName missionName: String = "") -> [Launch] {
        let validLaunches = launches.filter { $0.launchDate == nil || $0.launchDate! >= date }
        return validLaunches.filter { partialMatches($0.missionName, with: missionName) }
    }

    func launchesWhere(missionNameContains searchTerm: String) -> [Launch] {
        guard searchTerm.isEmpty == false else { return [] } //Should contain at least one character

        return launches.filter { partialMatches($0.missionName, with: searchTerm) }
    }
}

extension SearchEngine {
    private func partialMatches(_ string: String, with stringB: String) -> Bool {
        guard stringB.isEmpty == false else { return true } // won't match against empty strings

        // lowercased, trim whitespace and newline for better results
        let firstString = string.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let secondString = stringB.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        return firstString.range(of: secondString) != nil
    }
}
