import Foundation

class LaunchesDependencyContainer: DependencyContainer, LaunchesViewControllerFactory {

    func makeLaunchesViewController() -> LaunchesViewController {
        let api = makeSpaceXAPI()
        let repo = LaunchesRepository(with: api)

        return LaunchesViewController(with: repo)
    }
}
