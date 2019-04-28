import Foundation
import SpaceXAPI

struct LaunchesRepository {
    private let api: SpaceXAPI

    init(api: SpaceXAPI) {
        self.api = api
    }
}
