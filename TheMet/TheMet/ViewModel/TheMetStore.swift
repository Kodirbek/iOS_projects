
import Foundation

@Observable
class TheMetStore {
  var objects: [Object] = []
  private let service = TheMetService()
  let maxIndex: Int
  
  init(_ maxIndex: Int = 20) {
    self.maxIndex = maxIndex
  }
  
  func fetchObjects(for queryTerm: String) async throws {
    if let objectIDs = try await service.getObjectIDs(from: queryTerm) {
      for (index, objectID) in objectIDs.objectIDs.enumerated()
      where index < maxIndex {
        if let object = try await service.getObject(from: objectID) {
          await MainActor.run {
            objects.append(object)
          }
        }
      }
    }
  }
}
