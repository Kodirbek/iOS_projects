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
                viewModel.addLocation(at: coordinate)
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) {
                viewModel.update(location: $0)
            } onDelete: {
                viewModel.remove(location: $0)
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
