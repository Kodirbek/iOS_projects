
import Foundation

struct Object: Codable {
  let objectID: Int
  let title: String
  let creditLine: String
  let objectURL: String
  let isPublicDomain: Bool
  let primaryImageSmall: String
}

extension Object: Identifiable {
  var id: Int { objectID }
}

struct ObjectIDs: Codable {
  let total: Int
  let objectIDs: [Int]
}
