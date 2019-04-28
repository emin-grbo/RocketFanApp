import UIKit

class LaunchesCoordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController

        navigationController.viewControllers = [launchesViewController()]
    }
}

extension LaunchesCoordinator {
    private func launchesViewController() -> LaunchesViewController {
        return LaunchesViewController()
    }
}
