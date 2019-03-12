import Foundation

public extension SpaceXAPI {
    public struct Options {
        public var queryItems: [URLQueryItem] {
            var parameters: [String: String] = [:]

            if let options = filterOptions {
                parameters["filter"] = options.joined(separator: ",")
            }

            parameters["limit"] = String(limit)
            parameters["offset"] = String(offset)

            return parameters.map { URLQueryItem(name: $0, value: $1) }
        }

        private let filterOptions: [String]?
        private let limit: Int
        private let offset: Int

        /// Create result query options
        ///
        /// - Parameters:
        ///   - filterOptions: An optional array of query fields. If this is set then only these values will be returned
        ///   by the API. For example, specifying `flight_number` will only return `flight_number` values from the API.
        ///   - limit: Page limit to be returned, defaults to `25`
        ///   - offset: Page offset, defaults to `0`
        public init(filterOptions: [String]? = nil, limit: Int = 25, offset: Int = 0) {
            self.filterOptions = filterOptions
            self.limit = limit
            self.offset = offset
        }
    }
}
