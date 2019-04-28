import UIKit

class LaunchesCoordinator {
    let navigationController: UINavigationController
    private let dependencyContainer = LaunchesDependencyContainer()

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController

        navigationController.viewControllers = [launchesViewController()]
    }
}

extension LaunchesCoordinator {
    private func launchesViewController() -> LaunchesViewController {
        return dependencyContainer.makeLaunchesViewController()
    }
}
