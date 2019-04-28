import Foundation
import SpaceXAPI

protocol APIFactory {
    func makeSpaceXAPI() -> SpaceXAPI
}
