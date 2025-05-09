import SwiftUI

struct TerminalMapView: View {
  var flight: FlightInformation

  var body: some View {
    Group {
      if flight.terminal == "A" {
        Image("terminal-a-map")
          .resizable()
          .frame(maxWidth: .infinity)
          .aspectRatio(contentMode: .fit)
      } else {
        Image("terminal-b-map")
          .resizable()
          .frame(maxWidth: .infinity)
          .aspectRatio(contentMode: .fit)
      }
    }
    .overlay {
      TerminalStoresView(flight: flight)
      GatePathView(flight: flight)
        .foregroundColor(.white)
    }
  }
}

#Preview("Terminal A") {
  TerminalMapView(
    flight: FlightData.sampleTerminalAFlight
  )
}

#Preview("Termainl B") {
  TerminalMapView(
    flight: FlightData.sampleTerminalBFlight
  )
}
