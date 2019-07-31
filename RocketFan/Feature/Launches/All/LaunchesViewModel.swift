import Foundation
import Combine
import SwiftUI

class LaunchesViewModel: ObservableObject {
    var modelError: ((_ error: Error) -> Void)?
    var didFinishLoading: ((_ loaded: Bool) -> Void)?
    let didChange = PassthroughSubject<Void, Never>()

    private var repository: LaunchesRepositoryProtocol?
    private var searchEngine: SearchEngine?
    private(set) var launches: [Launch] = [] { didSet { didChange.send() } }

    private var currentSearchTerm = "" {
        didSet { loadLaunches(with: selectedFilter, withMissionName: currentSearchTerm) }
    }

    private var selectedFilter: Filter = .past {
        didSet { loadLaunches(with: selectedFilter, withMissionName: currentSearchTerm) }
    }

    init(with repo: LaunchesRepositoryProtocol) {
        repository = repo
        fetchAllLaunches()
    }
}

extension LaunchesViewModel {
    func findLaunchesMatching(_ searchTerm: String) {
        currentSearchTerm = searchTerm
    }

    func filterLaunches(by filter: Filter) {
        selectedFilter = filter
    }
}

extension LaunchesViewModel {
    private func fetchAllLaunches() {
        repository?.allLaunches { [weak self] (result) in

            do {
                let launches = try result.get()
                self?.searchEngine = SearchEngine(with: launches)
                let filter = self?.selectedFilter ?? .past
                self?.didFinishLoading?(true)
                self?.loadLaunches(with: filter)

            } catch {
                self?.modelError?(error)
            }
        }
    }

    private func loadLaunches(with filter: Filter, withMissionName missionName: String = "") {
        if filter == .past {
            let unSortedLaunches = searchEngine?.launches(before: Date(), withMissionName: missionName) ?? []
            launches = sort(unSortedLaunches, by: .descending)
        } else {
           let unSortedLaunches = searchEngine?.launches(after: Date(), withMissionName: missionName) ?? []
            launches = sort(unSortedLaunches, by: .ascending)
        }
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
