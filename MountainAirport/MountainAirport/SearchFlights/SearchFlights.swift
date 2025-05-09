import SwiftUI

struct SearchFlights: View {
  @State var flightData: [FlightInformation]
  @State private var date = Date()
  @State private var directionFilter: FlightDirection = .none
  @State private var city = ""
  @State private var runningSearch = false
  // swiftlint:disable:next attributes
  @Environment(\.colorScheme) var colorScheme: ColorScheme

  var pickerBackgroundColor: Color {
    colorScheme == .dark ? .black : .white
  }

  var matchingFlights: [FlightInformation] {
    var matchingFlights = flightData

    if directionFilter != .none {
      matchingFlights = matchingFlights.filter {
        $0.direction == directionFilter
      }
    }
    return matchingFlights
  }

  var flightDates: [Date] {
    let allDates = matchingFlights.map { $0.localTime.dateOnly }
    let uniqueDates = Array(Set(allDates))
    return uniqueDates.sorted()
  }

  func flightsForDay(date: Date) -> [FlightInformation] {
    matchingFlights.filter {
      Calendar.current.isDate($0.localTime, inSameDayAs: date)
    }
  }

  var body: some View {
    ZStack {
      Image("background-view")
        .resizable()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      VStack {
        Picker(
          selection: $directionFilter,
          label: Text("Flight Direction")) {
          Text("All").tag(FlightDirection.none)
          Text("Arrivals").tag(FlightDirection.arrival)
          Text("Departures").tag(FlightDirection.departure)
        }
        .background(pickerBackgroundColor)
        .pickerStyle(SegmentedPickerStyle())
        List {
          ForEach(flightDates, id: \.hashValue) { date in
            Section(
              header: Text(longDateFormatter.string(from: date)),
              footer:
                Text(
                  "Matching flights " + "\(flightsForDay(date: date).count)"
                )
                .frame(maxWidth: .infinity, alignment: .trailing)
            ) {
              ForEach(flightsForDay(date: date)) { flight in
                SearchResultRow(flight: flight)
              }
            }
          }
        }
        .overlay(
          Group {
            if runningSearch {
              VStack {
                Text("Searching...")
                ProgressView()
                  .progressViewStyle(CircularProgressViewStyle())
                  .tint(.black)
              }
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .background(.gray)
              .opacity(0.8)
            }
          }
        )
        .listStyle(InsetGroupedListStyle())
        Spacer()
      }
      .searchable(text: $city, prompt: "City Name") {
        ForEach(FlightData.citiesContaining(city), id: \.self) { city in
          Text(city).searchCompletion(city)
        }
      }
      .onSubmit(of: .search) {
        Task {
          runningSearch = true
          await flightData = FlightData.searchFlightsForCity(city)
          runningSearch = false
        }
      }
      .onChange(of: city) {
        if city.isEmpty {
          Task {
            runningSearch = true
            await flightData = FlightData.searchFlightsForCity(city)
            runningSearch = false
          }
        }
      }
      .navigationTitle("Search Flights")
      .padding()
    }
  }
}

#Preview {
  NavigationStack {
    SearchFlights(flightData: FlightData.generateTestFlights(date: Date())
    )
  }
  .environmentObject(AppEnvironment())
}
