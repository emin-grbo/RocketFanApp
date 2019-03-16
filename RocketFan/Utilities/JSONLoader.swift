import Foundation

enum JSONLoader {
    enum File: String {
        case capsule
        case core
        case history
        case landingPad = "landpad"
        case mission
        case roadster
        case ship
    }

    static func load(_ file: File) -> Data? {
        guard let path = Bundle.main.path(forResource: file.rawValue, ofType: "json") else {
            return nil
        }

      let url = URL(fileURLWithPath: path)

        return try? Data(contentsOf: url)
    }
}
