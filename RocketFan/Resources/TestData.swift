import Foundation

let launchesTestData: [Launch] = load(.launches)

private func load<T: Decodable>(_ file: JSONLoader.File, as type: T.Type = T.self) -> T {
    guard let data = JSONLoader.load(file) else {
        fatalError("Couldn't load \(file.rawValue)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(file.rawValue) as \(T.self):\n\(error)")
    }
}
