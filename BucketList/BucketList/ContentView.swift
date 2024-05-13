//
//  ContentView.swift
//  BucketList
//
//  Created by kodirbek on 5/13/24.
//

import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}


struct ContentView: View {
    
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
        MapReader { proxy in
            Map {
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "mappin.and.ellipse")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                            .shadow(color: .white, radius: 8, x: 4, y: 0)
                    }
                }
            }
            .mapStyle(.hybrid(elevation: .realistic))
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    print(coordinate)
                }
            }
        }
        .frame(height: 400, alignment: .center)
    }
}

#Preview {
    ContentView()
}
