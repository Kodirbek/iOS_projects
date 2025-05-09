import SwiftUI

struct FlightTimeHistory: View {
  var flight: FlightInformation

  var timeFormatter: RelativeDateTimeFormatter {
    let rtf = RelativeDateTimeFormatter()
    rtf.unitsStyle = .full
    rtf.dateTimeStyle = .named
    return rtf
  }

  func relativeDate(_ date: Date) -> String {
    return timeFormatter.localizedString(for: date, relativeTo: Date())
  }

  var body: some View {
    ZStack {
      Image("background-view")
        .resizable()
        .aspectRatio(contentMode: .fill)
      VStack {
        Text("On Time History for \(flight.statusBoardName)")
          .font(.title2)
          .padding(.top, 30)
        ScrollView {
          ForEach(flight.history, id: \.day) { history in
            HStack {
              Text("\(history.day) day(s) ago - \(history.flightDelayDescription)")
                .padding()
              Spacer()
            }
            .background(
              Color.white.opacity(0.2)
            )
          }
        }
        HistoryPieChart(flightHistory: flight.history)
          .font(.footnote)
          .frame(width: 250, height: 250)
          .padding(5)
      }
    }
    .foregroundColor(.white)
  }
}

#Preview {
  FlightTimeHistory(
    flight: FlightData.generateTestFlight(date: Date())
  )
}
