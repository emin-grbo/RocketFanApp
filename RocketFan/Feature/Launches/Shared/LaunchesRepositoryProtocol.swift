import Foundation

protocol LaunchesRepositoryProtocol: RepositoryProtocol {
    mutating func allLaunches(completion: @escaping (Result<[Launch], Error>) -> Void)
}
