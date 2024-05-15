//
//  ContentView.swift
//  BucketList
//
//  Created by kodirbek on 5/13/24.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State private var isUnlocked = false
    @State private var locations = [Location]()
    @State private var selectedPlace: Location?
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
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
                CustomContentUnavailableView(onTryAgain: authenticate)
            }
            
        }
        .onAppear(perform: authenticate)
        
    }
    
    // MARK: - Methods
    private func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    isUnlocked = true
                } else {
                    isUnlocked = false
                }
            }
        } else {
            // handle biometric auth fail case (e.g. password)
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
