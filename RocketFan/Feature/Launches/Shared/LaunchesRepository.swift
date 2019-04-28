import Foundation
import SpaceXAPI

struct LaunchesRepository {
    private let api: SpaceXAPI

    init(with api: SpaceXAPI) {
        self.api = api
    }
}
