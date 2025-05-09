import SwiftUI

struct FlightSearchDetails: View {
  var flight: FlightInformation
  @Binding var showModal: Bool
  @State private var rebookAlert = false
  @State private var phone = ""
  @State private var password = ""
  @State private var checkInFlight: CheckInInfo?
  @State private var showCheckIn = false
  @State private var showFlightHistory = false
  @EnvironmentObject var lastFlightInfo: AppEnvironment

  var body: some View {
    ZStack {
      Image("background-view")
        .resizable()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      VStack(alignment: .leading) {
        HStack {
          FlightDetailHeader(flight: flight)
          Spacer()
          Button("Close") {
            showModal = false
          }
        }
        if flight.status == .canceled {
          Button("Rebook Flight") {
            rebookAlert = true
          }
          .alert("Contact Your Airline", isPresented: $rebookAlert) {
            TextField("Phone", text: $phone)
            SecureField("Password", text: $password)
            Button("Call Me") {
            }
            Button("Cancel", role: .cancel) {
            }
          } message: {
            Text("We cannot rebook this flight. Please contact") +
            Text(" the airline to reschedule this flight.")
          }
        }
        if flight.isCheckInAvailable {
          Button("Check In for Flight") {
            checkInFlight =
              CheckInInfo(
                airline: flight.airline,
                flight: flight.number
              )
            showCheckIn = true
          }
          .confirmationDialog(
            "Check In",
            isPresented: $showCheckIn,
            presenting: checkInFlight
          ) { checkIn in
            Button("Check In") {
              print(
                "Check-in for \(checkIn.airline) \(checkIn.flight)."
              )
            }
            Button("Reschedule", role: .destructive) {
              print("Reschedule flight.")
            }
            Button("Not Now", role: .cancel) { }
          } message: { checkIn in
            Text("Check in for \(checkIn.airline)" +
              "Flight \(checkIn.flight)")
          }
        }
        Button("On-Time History") {
          showFlightHistory.toggle()
        }
        .sheet(isPresented: $showFlightHistory) {
          FlightTimeHistory(flight: flight)
        }
        FlightInfoPanel(flight: flight)
          .padding()
          .background(
            RoundedRectangle(cornerRadius: 20.0)
              .opacity(0.3)
          )
        Spacer()
      }
      .foregroundColor(.white)
      .padding()
    }
    .interactiveDismissDisabled()
    .onAppear {
      lastFlightInfo.lastFlightId = flight.id
    }
  }
}

#Preview {
  FlightSearchDetails(
    flight: FlightData.generateTestFlight(date: Date()),
    showModal: .constant(true)
  )
  .environmentObject(AppEnvironment())
}
