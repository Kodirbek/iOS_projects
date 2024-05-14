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
    
    @State private var isUnlocked = true
    @State private var locations = [Location]()
    @State private var selectedPlace: Location?
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    
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
                                Image(systemName: "mappin.and.ellipse")
                                    .imageScale(.large)
                                    .foregroundStyle(.black)
                                    .shadow(color: .white, radius: 8, x: 4, y: 0)
                                    .onLongPressGesture {
                                        selectedPlace = location
                                    }
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
                ContentUnavailableView {
                    Label("Authentication failed!", systemImage: "map.fill")
                } description: {
                    Text("Map will be presented once authentication is successful.")
                } actions: {
                    Button("Try Again") {
                        authenticate()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            
        }
        .onAppear(perform: authenticate)
        
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

#Preview {
    ContentView()
}
