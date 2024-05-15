//
//  ContentView.swift
//  BucketList
//
//  Created by kodirbek on 5/13/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State private var isUnlocked = false
    @State private var locations = [Location]()
    @State private var selectedPlace: Location?
    
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            if isUnlocked {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(locations) { location in
                            Annotation(location.name,
                                       coordinate: location.coordinate) {
                                CustomAnnotationMark(selectedPlace: $selectedPlace,
                                                     location: location)
                            }
                        }
                    }
                    .padding(.vertical)
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
            } else {
                CustomContentUnavailableView(onTryAgain: {
                    Authenticator.authenticate { isAuth in
                        isUnlocked = isAuth
                    }
                })
            }
            
        }
        .onAppear {
            Authenticator.authenticate { isAuth in
                isUnlocked = isAuth
            }
        }
        
    }
    
    // MARK: - Methods
    
}

// MARK: - Preview
#Preview {
    ContentView()
}
