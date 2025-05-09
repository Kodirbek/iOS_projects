import SwiftUI

struct TerminalAView: View {
  // swiftlint:disable:next attributes
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    ZStack {
      Image("background-view")
        .resizable()
        .rotationEffect(.degrees(180.0))
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      VStack(alignment: .leading) {
        Text("Terminal A")
          .font(.title)
          .padding()
        Text("Terminal A offers the follow stores:")
          .font(.title2)
        ForEach(TerminalStore.terminalStoresA) { store in
          Text("\u{2022} \(store.name)")
        }
        Spacer()
      }
      .foregroundColor(.white)
      .padding()
      .font(.title3)
    }
    .onTapGesture {
      dismiss()
    }
  }
}

#Preview {
  TerminalAView()
}
