import Foundation

var longDateFormatter: DateFormatter {
  let ldf = DateFormatter()
  ldf.dateStyle = .long
  ldf.timeStyle = .none

  return ldf
}
