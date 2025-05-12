import SwiftUI

struct TerminalStoresView: View {
  var flight: FlightInformation
  @State private var showStores = false

  var stores: [TerminalStore] {
    if flight.terminal == "A" {
      return TerminalStore.terminalStoresA
    } else {
      return TerminalStore.terminalStoresB
    }
  }

  var body: some View {
    GeometryReader { proxy in
      let width = proxy.size.width
      let height = proxy.size.height
      let storeWidth = width / 6
      let storeHeight = storeWidth / 1.75
      let storeSpacing = width / 5
      let firstStoreOffset = flight.terminal == "A" ?
      width - storeSpacing :
      storeSpacing - storeWidth
      let direction = flight.terminal == "A" ? -1.0 : 1.0
      ForEach(stores.indices, id: \.self) { index in
        let store = stores[index]
        let xOffset =
        Double(index) * storeSpacing * direction + firstStoreOffset
        RoundedRectangle(cornerRadius: 5.0)
          .foregroundColor(
            Color(
              hue: 0.3333,
              saturation: 1.0 - store.howBusy,
              brightness: 1.0 - store.howBusy
            )
          )
          .overlay(
            Text(store.shortName)
              .font(.footnote)
              .foregroundColor(.white)
              .shadow(radius: 5)
          )
          .frame(width: storeWidth, height: storeHeight)
          .offset(
            x: showStores ?
              xOffset :
              firstStoreOffset - direction * width,
            y: height * 0.4
          )
          .animation(.easeOut.delay(Double(index) * 0.35), value: showStores)
      }
    }
    .onAppear {
      withAnimation(.easeInOut) {
        showStores = true
      }
    }
  }
}

#Preview {
  TerminalStoresView(flight: FlightData.generateTestFlight(date: Date()))
}
