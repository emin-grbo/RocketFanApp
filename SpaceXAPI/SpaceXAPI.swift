import Foundation

final public class SpaceXAPI {
    private let baseURL = URL(string: "https://api.spacexdata.com/v3")!
    private let urlSession: NetworkSession

    public init(urlSession: NetworkSession) {
        self.urlSession = urlSession
    }

    public func get(_ endpoint: Endpoint,
                    parameters: [String: String]? = nil,
                    completion: @escaping (Result<Data>) -> Void) -> URLSessionTask {

        let url = buildURL(for: endpoint, using: parameters)

        let task = urlSession.dataTask(with: url) { data, urlResponse, error in
            if let error = error {
                completion(Result.error(error))
                return
            }

            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                completion(Result.error(SpaceXAPIError.unknownReponse))
                return
            }

            guard (200 ..< 300).contains(httpResponse.statusCode) else {
                completion(Result.error(SpaceXAPIError.serverReturnedCode(httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(Result.error(SpaceXAPIError.noDataReceived))
                return
            }

            completion(Result.success(data))
        }

        task.resume()

        return task
    }

    private func buildURL(for endpoint: Endpoint, using parameters: [String: String]?) -> URL {
        let url = baseURL.appendingPathComponent(endpoint.path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters?.map { URLQueryItem(name: $0, value: $1) }
        return components?.url ?? url
    }
}
