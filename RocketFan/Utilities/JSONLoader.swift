import Foundation

enum JSONLoader {
    enum File: String {
        case capsule
        case core
    }

    static func load(_ file: File) -> Data? {
        guard let path = Bundle.main.path(forResource: file.rawValue, ofType: "json") else {
            return nil
        }

      let url = URL(fileURLWithPath: path)

        return try? Data(contentsOf: url)
    }
}
