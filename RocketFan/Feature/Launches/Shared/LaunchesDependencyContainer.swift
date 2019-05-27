import Foundation

class LaunchesDependencyContainer: DependencyContainer, LaunchesViewControllerFactory {
    func makeLaunchesViewController() -> LaunchesViewController {
        return LaunchesViewController(with: makeViewModel())
    }
}

extension LaunchesDependencyContainer {
    private func makeViewModel() -> LaunchesViewModel {
        let repo = makeRepository()
        return LaunchesViewModel(with: repo)
    }

    private func makeRepository() -> LaunchesRepository {
        let api = makeSpaceXAPI()
        return LaunchesRepository(with: api)
    }
}
