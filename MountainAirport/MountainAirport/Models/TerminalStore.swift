import Foundation

struct TerminalStore: Identifiable {
  var id: Int
  var terminal: String
  var name: String
  var shortName: String
  var howBusy: Double {
    let minute = Calendar.current.dateComponents([.minute], from: Date()).minute ?? 0
    let adjustedMinute = (minute + id * 10) % 60
    let fraction = Double(adjustedMinute) / 60.0

    return fraction
  }

  static var allStores: [TerminalStore] {
    var stores: [TerminalStore] = []

    stores.append(TerminalStore(id: 1, terminal: "A", name: "Juniper Fiddler", shortName: "Juniper"))
    stores.append(TerminalStore(id: 2, terminal: "A", name: "Orange Emperor", shortName: "Orange"))
    stores.append(TerminalStore(id: 3, terminal: "A", name: "Aqua Sunset", shortName: "Aqua"))

    stores.append(TerminalStore(id: 4, terminal: "B", name: "The Olive Morning", shortName: "Olive"))
    stores.append(TerminalStore(id: 5, terminal: "B", name: "The Ruby Afternoon", shortName: "Ruby"))
    stores.append(TerminalStore(id: 6, terminal: "B", name: "Sunset Elements", shortName: "Sunset"))

    return stores
  }

  static var terminalStoresA: [TerminalStore] {
    return allStores.filter { $0.terminal == "A" }
  }

  static var terminalStoresB: [TerminalStore] {
    return allStores.filter { $0.terminal == "B" }
  }
}
