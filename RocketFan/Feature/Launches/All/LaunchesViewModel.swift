import Foundation

class LaunchesViewModel {
    private var repository: LaunchesRepositoryProtocol?
    private var searchEngine: SearchEngine?

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
        guard searchTerm.isEmpty == false else {
            loadPastLaunches()
            return
        }

        let results = searchEngine?.launchesWhere(missionNameContains: searchTerm)
        launchesUpdated?(results ?? [])
    }
}

extension LaunchesViewModel {
    private func fetchAllLaunches() {
        repository?.allLaunches { [weak self] (result) in

            do {
                let launches = try result.get()
                self?.searchEngine = SearchEngine(with: launches)
                self?.loadPastLaunches()

            } catch {
                self?.modelError?(error)
            }
        }
    }

    private func loadPastLaunches() {
        let currentDate = Date()
        guard let pastLaunches = searchEngine?.launches(before: currentDate) else { return }

        launchesUpdated?(pastLaunches)
    }
}
