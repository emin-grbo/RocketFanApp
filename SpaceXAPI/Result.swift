import Foundation

public enum Result<Data> {
    case success(Data)
    case error(Error)
}
