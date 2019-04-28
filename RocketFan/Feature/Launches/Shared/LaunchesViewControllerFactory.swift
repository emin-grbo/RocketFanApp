import Foundation

protocol LaunchesViewControllerFactory: ViewControllerFactory {
    func makeLaunchesViewController() -> LaunchesViewController
}
