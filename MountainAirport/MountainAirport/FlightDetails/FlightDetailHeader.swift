import SwiftUI

struct FlightDetailHeader: View {
  var flight: FlightInformation

  var body: some View {
    HStack {
      FlightStatusIcon(flight: flight)
        .frame(width: 40, height: 40)
      VStack(alignment: .leading) {
        Text("\(flight.dirString) \(flight.otherAirport)")
        Text(flight.flightStatus)
          .font(.subheadline)
      }.font(.title2)
    }
  }
}

#Preview {
  FlightDetailHeader(
    flight: FlightData.generateTestFlight(date: Date())
  )
}
