import SwiftUI

struct AwardInformation {
  public var imageName: String
  public var title: String
  public var description: String
  public var awarded: Bool
  public var stars: Int = 3
}

extension AwardInformation: Hashable {
  static func == (lhs: AwardInformation, rhs: AwardInformation) -> Bool {
    if lhs.title == rhs.title && lhs.description == rhs.description && lhs.awarded == rhs.awarded {
      return true
    }

    return false
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(title)
    hasher.combine(description)
    hasher.combine(awarded)
    hasher.combine(stars)
  }
}

extension AwardInformation: Identifiable {
  public var id: Int {
    self.hashValue
  }
}
