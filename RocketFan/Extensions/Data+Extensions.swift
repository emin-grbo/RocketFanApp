import Foundation

extension Data {
    func decoded<T: Decodable>(useing decoder: AnyDecoder = JSONDecoder()) throws -> T {
        return try decoder.decoded(T.self, from: self)
    }
}
