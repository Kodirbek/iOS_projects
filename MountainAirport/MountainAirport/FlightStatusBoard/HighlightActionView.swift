import SwiftUI

struct HighlightActionView: View {
  var flightId: Int
  @Binding var highlightedIds: [Int]

  func toggleHighlight() {
    let flightIdx = highlightedIds.firstIndex { $0 == flightId
    }
    if let index = flightIdx {
      highlightedIds.remove(at: index)
    } else {
      highlightedIds.append(flightId)
    }
  }

  var body: some View {
    Button {
      toggleHighlight()
    } label: {
      Image(systemName: "highlighter")
    }
    .tint(Color.yellow)
  }
}

#Preview {
  HighlightActionView(
    flightId: 1,
    highlightedIds: .constant([1])
  )
}
