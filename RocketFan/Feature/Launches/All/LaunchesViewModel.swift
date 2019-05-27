import Foundation

class LaunchesViewModel {
    private var repository: LaunchesRepository?

    var modelError: ((_ error: Error) -> Void)?
    var launchesUpdated: ((_ launches: [Launch]) -> Void)? {
        didSet { fetchAllLaunches() }
    }

    init(with repo: LaunchesRepository) {
        repository = repo
    }
}

extension LaunchesViewModel {
    private func fetchAllLaunches() {
        repository?.allLaunches { [weak self] (result) in

            do {
                let launches = try result.get()
                self?.launchesUpdated?(launches)

            } catch {

            }
        }
    }
}
