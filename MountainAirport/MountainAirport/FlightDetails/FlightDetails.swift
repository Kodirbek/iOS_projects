import SwiftUI

struct FlightDetails: View {
  var flight: FlightInformation
  @State private var showTerminalInfo = false
  @EnvironmentObject var lastFlightInfo: AppEnvironment

  var body: some View {
    ZStack {
      Image("background-view")
        .resizable()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      VStack(alignment: .leading) {
        FlightDetailHeader(flight: flight)
        FlightInfoPanel(flight: flight)
          .frame(maxWidth: .infinity, alignment: .topLeading)
          .padding()
          .background(
            RoundedRectangle(cornerRadius: 20.0)
              .opacity(0.3)
          )
        Spacer()
      }
      .foregroundColor(.white)
      .padding()
      .navigationTitle("\(flight.airline) Flight \(flight.number)")
    }
    .contentShape(Rectangle())
    .onTapGesture {
      showTerminalInfo.toggle()
    }
    .sheet(isPresented: $showTerminalInfo) {
      Group {
        if flight.terminal == "A" {
          TerminalAView()
        } else {
          TerminalBView()
        }
      }
      .presentationDetents([.medium, .large])
    }
    .onAppear {
      lastFlightInfo.lastFlightId = flight.id
    }
  }
}

#Preview {
  NavigationStack {
    FlightDetails(
      flight: FlightData.generateTestFlight(date: Date())
    )
    .environmentObject(AppEnvironment())
  }
}
