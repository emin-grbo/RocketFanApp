import Foundation

protocol AnyDecoder {
    func decoded<T: Decodable>(_ type: T.Type, from data: Data)throws -> T
}

extension JSONDecoder: AnyDecoder {
    func decoded<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        return try decode(type, from: data)
    }
}

protocol AnyEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}

extension JSONEncoder: AnyEncoder {
    func encode<T>(_ value: T) throws -> Data where T: Encodable {
        return try encode(value)
    }
}
