import Foundation
import SpaceXAPI

class DependencyContainer {
    func makeSpaceXAPI() -> SpaceXAPI {
        return SpaceXAPI(urlSession: URLSession.shared)
    }
}

extension DependencyContainer: ViewControllerFactory {

}
