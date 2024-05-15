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
                    MapView(proxy: proxy,
                            locations: $locations,
                            selectedPlace: $selectedPlace)
                }
            } else {
                CustomContentUnavailableView(onTryAgain: {
                    Task {
                        isUnlocked = await Authenticator.authenticate()
                    }
                })
            }
            
        }
        .onAppear {
            Task {
                isUnlocked = await Authenticator.authenticate()
            }
        }
        
    }
    
    // MARK: - Methods
    
}

// MARK: - Preview
#Preview {
    ContentView()
}
