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
    @Bindable var viewModel: ContentViewVM
    
    
    // MARK: - Body
    var body: some View {
        Map(initialPosition: startPosition) {
            ForEach(viewModel.locations) { location in
                Annotation(location.name,
                           coordinate: location.coordinate) {
                    CustomAnnotationMark(selectedPlace: $viewModel.selectedPlace,
                                         location: location)
                }
            }
        }
        .mapStyle(.hybrid(elevation: .realistic))
        .onTapGesture { position in
            if let coordinate = proxy.convert(position, from: .local) {
                let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                viewModel.locations.append(newLocation)
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) { newLocation in
                if let index = viewModel.locations.firstIndex(of: place) {
                    viewModel.locations[index] = newLocation
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    MapReader { proxy in
        return MapView(proxy: proxy,
                       viewModel: ContentViewVM())
    }
}
