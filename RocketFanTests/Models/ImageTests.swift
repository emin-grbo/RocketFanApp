import XCTest
import SwiftUI
@testable import RocketFan

class ImageTests: XCTestCase {

    func test_images_areInBundle() {
        for image in RFIcons.allCases {
            let image = Image(image.rawValue)
            XCTAssertNotNil(image, "Failed to load: \(image)")
        }
    }

}
