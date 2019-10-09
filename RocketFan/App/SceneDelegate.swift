import UIKit

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        //swiftlint:disable force_cast
        window = UIWindow(windowScene: scene as! UIWindowScene)

        setupTabBarController()
        window?.makeKeyAndVisible()
    }
}

extension SceneDelegate {
    private func setupTabBarController() {
        window?.rootViewController = MainTabBarController()
    }
}
