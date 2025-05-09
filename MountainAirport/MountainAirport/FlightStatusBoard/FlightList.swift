import SwiftUI

struct FlightList: View {
  var flights: [FlightInformation]
  var flightToShow: FlightInformation?
  @State private var path: [FlightInformation] = []
  @Binding var highlightedIds: [Int]

  func rowHighlighted(_ flightId: Int) -> Bool {
    return highlightedIds.contains { $0 == flightId }
  }

  var nextFlightId: Int {
    guard let flight = flights.first(
      where: {
        $0.localTime >= Date()
      }
    ) else {
      return flights.last?.id ?? 0
    }
    return flight.id
  }

  var body: some View {
    NavigationStack(path: $path) {
      ScrollViewReader { scrollProxy in
        List(flights) { flight in
          NavigationLink(value: flight) {
            FlightRow(flight: flight)
          }
          .swipeActions(edge: .leading) {
            HighlightActionView(flightId: flight.id, highlightedIds: $highlightedIds)
          }
          .listRowBackground(
            rowHighlighted(flight.id) ? Color.yellow.opacity(0.6) : Color.clear
          )
        }
        .navigationDestination(for: FlightInformation.self) { flight in
          FlightDetails(flight: flight)
        }
        .onAppear {
          scrollProxy.scrollTo(nextFlightId, anchor: .center)
        }
      }
    }
    .onAppear {
      if let flight = flightToShow {
        path.append(flight)
      }
    }
  }
}

#Preview {
  NavigationStack {
    FlightList(
      flights: FlightData.generateTestFlights(date: Date()),
      highlightedIds: .constant([15])
    )
  }
  .environmentObject(AppEnvironment())
}
