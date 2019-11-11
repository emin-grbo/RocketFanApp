import Foundation

protocol Persistable {
    func object(forKey: String) -> Any?
    func integer(forKey defaultName: String) -> Int
    func bool(forKey: String) -> Bool
    func set(_ value: Bool, forKey: String)
    func set(_ value: Int, forKey: String)
}

extension UserDefaults: Persistable { }
