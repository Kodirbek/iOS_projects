//
//  MapView.swift
//  BucketList
//
//  Created by kodirbek on 5/15/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    // MARK: - Properties
    var proxy: MapProxy
    @Binding var locations: [Location]
    @Binding var selectedPlace: Location?
    
    
    // MARK: - Body
    var body: some View {
        Map(initialPosition: startPosition) {
            ForEach(locations) { location in
                Annotation(location.name,
                           coordinate: location.coordinate) {
                    CustomAnnotationMark(selectedPlace: $selectedPlace,
                                         location: location)
                }
            }
        }
        .mapStyle(.hybrid(elevation: .realistic))
        .onTapGesture { position in
            if let coordinate = proxy.convert(position, from: .local) {
                let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                locations.append(newLocation)
            }
        }
        .sheet(item: $selectedPlace) { place in
            EditView(location: place) { newLocation in
                if let index = locations.firstIndex(of: place) {
                    locations[index] = newLocation
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    MapReader { proxy in
        return MapView(proxy: proxy,
                locations: .constant([]),
                selectedPlace: .constant(.example))
    }
}
