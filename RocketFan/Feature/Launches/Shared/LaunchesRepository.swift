import Foundation
import SpaceXAPI

struct LaunchesRepository {
    private let api: SpaceXAPI
    private var sessionTask: URLSessionTask?

    init(with api: SpaceXAPI) {
        self.api = api
    }

    func cancelCurrentTask() {
        sessionTask?.cancel()
    }
}

extension LaunchesRepository {
    mutating func allLaunches(completion: @escaping (Result<[Launch], Error>) -> Void) {
        sessionTask = api.get(Launches.all) { (result) in
            do {

                let data = try result.get()
                let decoder = JSONDecoder(dateDecodingStrategy: .secondsSince1970)
                let launches = try decoder.decoded([Launch].self, from: data)

                completion(.success(launches))

            } catch {
                completion(.failure(error))

            }
        }
    }
}
