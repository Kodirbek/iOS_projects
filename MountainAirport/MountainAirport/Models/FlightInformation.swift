import SwiftUI

enum FlightDirection {
  case none
  case arrival
  case departure
}

enum FlightStatus: String, CaseIterable {
  case ontime = "On Time"
  case delayed = "Delayed"
  case canceled = "Canceled"
  case landed = "Landed"
  case departed = "Departed"
}

class FlightInformation: NSObject {
  var id: Int
  var airline: String
  var number: String
  var otherAirport: String
  var otherCoordinates: (lat: Double, long: Double)
  var flightTime: Int
  var scheduledTime: Date
  var currentTime: Date?
  var direction: FlightDirection
  var status: FlightStatus
  var gate: String
  var history: [FlightHistory]

  var isCheckInAvailable: Bool {
    direction == .departure && flightStatus != "Departed"
  }

  var localTime: Date {
    currentTime ?? scheduledTime
  }

  var flightName: String {
    "\(airline) \(number)"
  }

  var dirString: String {
    direction == .arrival ? "From" : "To"
  }

  var statusBoardName: String {
    "\(flightName) \(dirString) \(otherAirport)"
  }

  var terminal: String {
    return String(gate.prefix(1))
  }

  var gateNumber: Int? {
    let gateNumberString = gate.dropFirst()
    return Int(gateNumberString)
  }

  var otherEndTime: Date {
    var multiplier: Int
    if direction == .arrival {
      multiplier = -1
    } else {
      multiplier = 1
    }
    // swiftlint:disable:next force_unwrapping
    return Calendar.current.date(byAdding: .minute, value: multiplier * flightTime, to: currentTime ?? scheduledTime)!
  }

  var departureTime: Date {
    if direction == .arrival {
      return otherEndTime
    } else {
      return localTime
    }
  }

  var arrivalTime: Date {
    if direction == .departure {
      return otherEndTime
    } else {
      return localTime
    }
  }

  var scheduledTimeString: String {
    let timeFormatter = DateFormatter()
    timeFormatter.dateStyle = .none
    timeFormatter.timeStyle = .short
    return timeFormatter.string(from: scheduledTime)
  }

  public var currentTimeString: String {
    guard let time = currentTime else { return "N/A" }
    let timeFormatter = DateFormatter()
    timeFormatter.dateStyle = .none
    timeFormatter.timeStyle = .short
    return timeFormatter.string(from: time)
  }

  var flightStatus: String {
    let now = Date()

    if status == .canceled {
      return status.rawValue
    }

    guard let currentTime = currentTime else {
      fatalError("currentTime can only be nil if status is canceled")
    }

    if direction == .arrival && now > currentTime {
      return "Arrived"
    }
    if direction == .departure && now > currentTime {
      return "Departed"
    }

    return status.rawValue
  }

  var timeDifference: Int {
    guard let actual = currentTime else { return 60 }
    let diff = Calendar.current.dateComponents([.minute], from: scheduledTime, to: actual)
    // swiftlint:disable:next force_unwrapping
    return diff.minute!
  }

  var statusColor: Color {
    if status == .canceled {
      return Color(red: 0.5, green: 0, blue: 0)
    }

    if timeDifference <= 0 {
      return Color(red: 0.0, green: 0.6, blue: 0)
    }

    if timeDifference <= 15 {
      return Color.yellow
    }

    return Color.red
  }

  var timelineColor: UIColor {
    if status == .canceled {
      return UIColor(red: 0.5, green: 0, blue: 0, alpha: 1)
    }

    if timeDifference <= 0 {
      return UIColor(red: 0.0, green: 0.6, blue: 0, alpha: 1)
    }

    if timeDifference <= 15 {
      return UIColor.yellow
    }

    return UIColor.red
  }

  var isToday: Bool {
    Calendar.current.isDateInToday(localTime)
  }

  init(
    recordId: Int,
    airline: String,
    number: String,
    connection: String,
    airportLocation: (lat: Double, long: Double),
    flightTime: Int,
    scheduledTime: Date,
    currentTime: Date?,
    direction: FlightDirection,
    status: FlightStatus,
    gate: String
  ) {
    self.id = recordId
    self.airline = airline
    self.number = number
    self.otherAirport = connection
    self.otherCoordinates = airportLocation
    self.flightTime = flightTime
    self.scheduledTime = scheduledTime
    self.currentTime = currentTime
    self.direction = direction
    self.status = status
    self.gate = gate
    self.history = []
  }
}

extension FlightInformation: Identifiable {
}
