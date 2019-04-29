import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var tabBarController: MainTabBarController?

    //swiftlint:disable line_length
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        setupTabBarController()
        window?.makeKeyAndVisible()

        return true
    }
}

extension AppDelegate {
    private func setupTabBarController() {
        tabBarController = MainTabBarController()
        window?.rootViewController = tabBarController
    }
}
