import Foundation

final public class SpaceXAPI {
    private let baseURL = URL(string: "https://api.spacexdata.com/v3")!
    private let urlSession: NetworkSession

    public init(urlSession: NetworkSession) {
        self.urlSession = urlSession
    }

    public func get(_ endpoint: Endpoint,
                    options: Options? = nil,
                    completion: @escaping (Result<Data>) -> Void) -> URLSessionTask {

        let url = buildURL(for: endpoint, using: options)

        let task = urlSession.dataTask(with: url) { data, urlResponse, error in
            if let error = error {
                completion(Result.error(error))
                return
            }

            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                completion(Result.error(SpaceXAPIError.unknownResponse))
                return
            }

            guard (200 ..< 300).contains(httpResponse.statusCode) else {
                completion(Result.error(SpaceXAPIError.serverReturnedCode(httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(Result.error(SpaceXAPIError.emptyResponse))
                return
            }

            completion(Result.success(data))
        }

        task.resume()

        return task
    }

    private func buildURL(for endpoint: Endpoint, using options: Options?) -> URL {
        let url = baseURL.appendingPathComponent(endpoint.path)

        guard let options = options else { return url }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = options.queryItems

        return components?.url ?? url
    }
}
