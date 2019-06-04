import Foundation

class LaunchesViewModel {
    private var repository: LaunchesRepositoryProtocol?
    private var searchEngine: SearchEngine?
    private var selectedFilter: Filter = .past
    private var currentSearchTerm = ""

    var modelError: ((_ error: Error) -> Void)?
    var launchesUpdated: ((_ launches: [Launch]) -> Void)? {
        didSet { fetchAllLaunches() }
    }

    init(with repo: LaunchesRepositoryProtocol) {
        repository = repo
    }
}

extension LaunchesViewModel {
    func findLaunchesMatching(_ searchTerm: String) {
        currentSearchTerm = searchTerm

        loadLaunches(with: selectedFilter, withMissionName: currentSearchTerm)
    }

    func filterLaunches(by filter: Filter) {
        selectedFilter = filter

        loadLaunches(with: selectedFilter, withMissionName: currentSearchTerm)
    }
}

extension LaunchesViewModel {
    private func fetchAllLaunches() {
        repository?.allLaunches { [weak self] (result) in

            do {
                let launches = try result.get()
                self?.searchEngine = SearchEngine(with: launches)
                let filter = self?.selectedFilter ?? .past
                self?.loadLaunches(with: filter)

            } catch {
                self?.modelError?(error)
            }
        }
    }

    private func loadLaunches(with filter: Filter, withMissionName missionName: String = "") {
        var launches: [Launch]

        if filter == .past {
            let unSortedLaunches = searchEngine?.launches(before: Date(), withMissionName: missionName) ?? []
            launches = sort(unSortedLaunches, by: .descending)
        } else {
           let unSortedLaunches = searchEngine?.launches(after: Date(), withMissionName: missionName) ?? []
            launches = sort(unSortedLaunches, by: .ascending)
        }

        launchesUpdated?(launches)
    }

    private func sort(_ launches: [Launch], by sortOrder: SortOrder) -> [Launch] {
        return sortOrder == .descending ? launches.sorted(by: >) : launches.sorted(by: <)
    }
}

extension LaunchesViewModel {
    enum Filter {
        case past
        case upcoming
    }

    private enum SortOrder {
        case descending
        case ascending
    }
}
