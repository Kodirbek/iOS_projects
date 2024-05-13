//
//  ContentView.swift
//  BucketList
//
//  Created by kodirbek on 5/13/24.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}


struct ContentView: View {
    
    @State private var isUnlocked = false
    
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            if isUnlocked {
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
                    .padding(.vertical)
                    .mapStyle(.hybrid(elevation: .realistic))
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            print(coordinate)
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
