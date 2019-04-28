import UIKit

class MainTabBarController: UITabBarController {
    private let launchesCoordinator = LaunchesCoordinator()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [launchesCoordinator.navigationController]
    }
}
