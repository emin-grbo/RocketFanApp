import Foundation
import SpaceXAPI

class DependencyContainer: ViewControllerFactory {

}

extension DependencyContainer: APIFactory {
    func makeSpaceXAPI() -> SpaceXAPI {
        return SpaceXAPI(urlSession: URLSession.shared)
    }
}
