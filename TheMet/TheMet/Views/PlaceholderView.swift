
import SwiftUI

struct PlaceholderView: View {
  let note: String
  var body: some View {
    ZStack {
      Rectangle()
        .inset(by: 7)
        .fill(Color.metForeground)
        .border(Color.metBackground, width: 7)
        .padding()
      Text(note)
        .foregroundColor(.metBackground)
    }
  }
}

#Preview {
  PlaceholderView(note: "Display image here")
}
