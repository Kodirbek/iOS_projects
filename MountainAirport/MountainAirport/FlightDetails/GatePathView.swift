import SwiftUI

struct GatePathView: View {
  var flight: FlightInformation
  @State private var showPath = false
  var walkingAnimation: Animation {
    .linear(duration: 2.5)
    .repeatForever(autoreverses: false)
  }

  let gateAPaths = [
    [
      CGPoint(x: 360, y: 128),
      CGPoint(x: 225, y: 128),
      CGPoint(x: 225, y: 70)
    ],
    [
      CGPoint(x: 360, y: 128),
      CGPoint(x: 172, y: 128),
      CGPoint(x: 172, y: 70)
    ],
    [
      CGPoint(x: 360, y: 128),
      CGPoint(x: 116, y: 128),
      CGPoint(x: 116, y: 70)
    ],
    [
      CGPoint(x: 360, y: 128),
      CGPoint(x: 46, y: 128)
    ],
    [
      CGPoint(x: 360, y: 128),
      CGPoint(x: 116, y: 128),
      CGPoint(x: 116, y: 187),
      CGPoint(x: 46, y: 187)
    ]
  ]

  let gateBPaths = [
    [
      CGPoint(x: 0, y: 128),
      CGPoint(x: 142, y: 128),
      CGPoint(x: 142, y: 70)
    ],
    [
      CGPoint(x: 0, y: 128),
      CGPoint(x: 197, y: 128),
      CGPoint(x: 197, y: 70)
    ],
    [
      CGPoint(x: 0, y: 128),
      CGPoint(x: 252, y: 128),
      CGPoint(x: 252, y: 70)
    ],
    [
      CGPoint(x: 0, y: 128),
      CGPoint(x: 315, y: 128)
    ],
    [
      CGPoint(x: 0, y: 128),
      CGPoint(x: 252, y: 128),
      CGPoint(x: 252, y: 185),
      CGPoint(x: 315, y: 185)
    ]
  ]

  func gatePath(_ proxy: GeometryProxy) -> [CGPoint] {
    guard let gateNumber = flight.gateNumber else { return [] }

    var pathPoints: [CGPoint]
    if flight.terminal == "A" {
      pathPoints = gateAPaths[gateNumber - 1]
    } else {
      pathPoints = gateBPaths[gateNumber - 1]
    }

    let ratioX = proxy.size.width / 360.0
    let ratioY = proxy.size.height / 480.0
    var points: [CGPoint] = []
    for pnt in pathPoints {
      let newPoint = CGPoint(
        x: pnt.x * ratioX, y: pnt.y * ratioY
      )
      points.append(newPoint)
    }
    return points
  }

  var mapName: String {
    "terminal-\(flight.terminal)-map".lowercased()
  }

  var body: some View {
    GeometryReader { proxy in
      WalkPath(points: gatePath(proxy))
        .trim(to: showPath ? 1.0 : 0.0)
        .stroke(lineWidth: 3.0)
        .animation(walkingAnimation, value: showPath)
    }
    .onAppear {
      showPath = true
    }
  }
}

struct WalkPath: Shape {
  var points: [CGPoint]
  
  func path(in rect: CGRect) -> Path {
    return Path { path in
      guard points.count > 1 else { return }
      path.addLines(points)
    }
  }
}


#Preview("Gate A") {
  var testGateA: FlightInformation {
    let flight = FlightData.generateTestFlight(date: Date())
    flight.gate = "A3"
    return flight
  }

  return GatePathView(flight: testGateA)
}

#Preview("Gate B") {
  var testGateB: FlightInformation {
    let flight = FlightData.generateTestFlight(date: Date())
    flight.gate = "B4"
    return flight
  }

  return GatePathView(flight: testGateB)
}
