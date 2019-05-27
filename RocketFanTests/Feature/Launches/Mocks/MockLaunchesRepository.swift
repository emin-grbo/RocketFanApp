import Foundation
import SpaceXAPI

@testable import RocketFan

struct MockLaunchesRepository: LaunchesRepositoryProtocol {
    private let launches: [Launch]?

    internal var api: SpaceXAPI {
        return SpaceXAPI(urlSession: URLSession.shared)
    }

    init(with launches: [Launch]?) {
        self.launches = launches
    }

    mutating func allLaunches(completion: @escaping (Result<[Launch], Error>) -> Void) {
        guard let launches = launches else {
            let errorTemp = NSError(domain: "", code: 400, userInfo: nil)
            completion(.failure(errorTemp))
            return
        }

        completion(.success(launches))
    }
}
