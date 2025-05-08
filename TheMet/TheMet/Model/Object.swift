
import Foundation

struct Object {
  let objectID: Int
  let title: String
  let creditLine: String
  let objectURL: String
  let isPublicDomain: Bool
  let primaryImageSmall: String
  var isFavorite = false
}

extension Object: Identifiable {
  var id: Int { objectID }
}

extension Object: Codable {
  enum CodingKeys: CodingKey {
    case objectID, title, creditLine, objectURL, isPublicDomain, primaryImageSmall
  }
}

struct ObjectIDs: Codable {
  let total: Int
  let objectIDs: [Int]
}
