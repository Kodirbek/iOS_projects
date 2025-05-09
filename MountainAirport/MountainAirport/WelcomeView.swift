import SwiftUI

enum FlightViewId: CaseIterable {
  case showFlightStatus
  case searchFlights
  case showLastFlight
  case showAwards
}

struct ViewButton: Identifiable {
  var id: FlightViewId
  var title: String
  var subtitle: String
  var imageName: String
}

struct WelcomeView: View {
  @StateObject var flightInfo = FlightData()
  @StateObject private var appEnvironment = AppEnvironment()
  @State private var selectedView: FlightViewId?

  var sidebarButtons: [ViewButton] {
    var buttons: [ViewButton] = []

    buttons.append(
      ViewButton(
        id: .showFlightStatus,
        title: "Flight Status",
        subtitle: "Departure and arrival information",
        imageName: "airplane"
      )
    )

    buttons.append(
      ViewButton(
        id: .searchFlights,
        title: "Search Flights",
        subtitle: "Search Upcoming Flights",
        imageName: "magnifyingglass"
      )
    )

    buttons.append(
      ViewButton(
        id: .showAwards,
        title: "Your Awards",
        subtitle: "Earn rewards for your airport interactions",
        imageName: "star"
      )
    )

    if
      let flightId = appEnvironment.lastFlightId,
      let flight = flightInfo.getFlightById(flightId) {
      buttons.append(
        ViewButton(
          id: .showLastFlight,
          title: "\(flight.flightName)",
          subtitle: "The Last Flight You Viewed",
          imageName: "suit.heart.fill"
        )
      )
    }

    return buttons
  }

  var body: some View {
    NavigationSplitView {
      List(sidebarButtons, selection: $selectedView) { button in
        WelcomeButtonView(
          title: button.title,
          subTitle: button.subtitle,
          imageName: button.imageName
        )
      }
      .navigationTitle("Mountain Airport")
      .listStyle(.plain)
    } detail: {
      if let view = selectedView {
        switch view {
        case .showFlightStatus:
          FlightStatusBoard(flights: flightInfo.getDaysFlights(Date()))
        case .searchFlights:
          SearchFlights(flightData: flightInfo.flights)
        case .showLastFlight:
          if
            let id = appEnvironment.lastFlightId,
            let lastFlight = flightInfo.getFlightById(id) {
            FlightStatusBoard(
              flights: flightInfo.getDaysFlights(Date()),
              flightToShow: lastFlight
            )
          }
        case .showAwards:
          AwardsView()
        }
      } else {
        Text("Select an option in the sidebar.")
      }
    }
    .environmentObject(appEnvironment)
  }
}

#Preview {
  WelcomeView()
}
