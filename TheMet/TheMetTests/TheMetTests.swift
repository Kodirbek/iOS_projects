import XCTest
@testable import TheMet

final class TheMetTests: XCTestCase {
  var sut: TheMetStore!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = MockMetStore(3)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  func testMaxIndexObjectsFetched() async throws {
    try await sut.fetchObjects(for: "rhino")
    XCTAssertLessThanOrEqual(sut.objects.count, sut.maxIndex)
  }
}
