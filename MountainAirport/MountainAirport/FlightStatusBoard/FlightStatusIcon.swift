import SwiftUI

struct FlightStatusIcon: View {
  var flight: FlightInformation

  var body: some View {
    if flight.status == .canceled {
      Image(systemName: "nosign")
        .resizable()
        .frame(width: 30, height: 30)
        .foregroundColor(.white)
        .background(
          RoundedRectangle(cornerRadius: 2)
            .frame(width: 40, height: 40)
            .foregroundColor(.red)
        )
        .frame(width: 40, height: 40)
    } else if flight.direction == .arrival {
      Image(systemName: "airplane")
        .resizable()
        .frame(width: 30, height: 30)
        .rotationEffect(.degrees(45.0))
        .foregroundColor(.white)
        .background(
          RoundedRectangle(cornerRadius: 2)
            .frame(width: 40, height: 40)
            .foregroundColor(
              Color(red: 0.89, green: 0.33, blue: 0.69)
            )
        )
    } else if flight.direction == .departure {
      Image(systemName: "airplane")
        .resizable()
        .frame(width: 30, height: 30)
        .rotationEffect(.degrees(-45.0))
        .foregroundColor(.white)
        .background(
          RoundedRectangle(cornerRadius: 2)
            .frame(width: 40, height: 40)
            .foregroundColor(
              Color(red: 0.19, green: 0.15, blue: 0.91)
            )
        )
    }
  }
}

#Preview {
  FlightStatusIcon(
    flight: FlightData.generateTestFlight(date: Date())
  )
}
