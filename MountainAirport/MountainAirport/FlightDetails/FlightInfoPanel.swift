import SwiftUI

struct FlightInfoPanel: View {
  var flight: FlightInformation
  @State private var showTerminal = false

  var timeFormatter: DateFormatter {
    let tdf = DateFormatter()
    tdf.timeStyle = .short
    tdf.dateStyle = .none
    return tdf
  }

  var body: some View {
    HStack(alignment: .top) {
      Image(systemName: "info.circle")
        .resizable()
        .frame(width: 35, height: 35, alignment: .leading)
      VStack(alignment: .leading) {
        Text("Flight Details")
          .font(.title2)
        if flight.direction == .arrival {
          Text("Arriving at Gate \(flight.gate)")
          Text("Flying from \(flight.otherAirport)")
        } else {
          Text("Departing from Gate \(flight.gate)")
          Text("Flying to \(flight.otherAirport)")
        }
        Text(flight.flightStatus) + Text(" (\(timeFormatter.string(from: flight.localTime)))")
        Button {
          withAnimation(
            .spring(duration: 0.55, bounce: 0.45, blendDuration: 0)
          ) {
            showTerminal.toggle()
          }
        } label: {
          HStack {
            Text(showTerminal ? "Hide Terminal Map" : "Show Terminal Map")
            Spacer()
            Image(systemName: "airplane.circle")
              .imageScale(.large)
              .padding(10)
              .rotationEffect(.degrees(showTerminal ? 90 : 270))
              .scaleEffect(showTerminal ? 1.2 : 1.0)
          }
        }
        if showTerminal {
          TerminalMapView(flight: flight)
        }
        Spacer()
      }
    }
  }
}

#Preview {
  FlightInfoPanel(
    flight: FlightData.generateTestFlight(date: Date())
  )
}
