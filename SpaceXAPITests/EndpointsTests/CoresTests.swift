import XCTest
@testable import SpaceXAPI

class CoresTests: XCTestCase {
    
    func test_Cores_All_ReturnsPath() {
        let path = Cores.all.path
        
        XCTAssertEqual(path, "/cores")
    }
    
    func test_Cores_One_ReturnsPth() {
        let identifider = "B1042"
        
        let path = Cores.one(identifider).path
        
        XCTAssertEqual(path, "/cores/\(identifider)")
    }
    
    func test_Cores_Upcoming_ReturnsPath() {
        let path = Cores.upcoming.path
        
        XCTAssertEqual(path, "/cores/upcoming")
    }
    
    func test_Cores_Past_ReturnsPath() {
        let path = Cores.past.path
        
        XCTAssertEqual(path, "/cores/past")
    }
}
