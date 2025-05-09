import Foundation

extension Date {
  var dateOnly: Date {
    let cdc = Calendar.current.dateComponents([.month, .day, .year], from: self)
    // swiftlint:disable:next force_unwrapping
    return Calendar.current.date(from: cdc)!
  }
}
