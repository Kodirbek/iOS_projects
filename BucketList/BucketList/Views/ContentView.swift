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
    
    @State private var viewModel: ContentViewVMProtocol
    
    init(viewModel: ContentViewVMProtocol) {
        self.viewModel  = viewModel
    }
    
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
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
            .navigationTitle("Bucket list")
            .navigationBarTitleDisplayMode(.inline)
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
    ContentView(viewModel: ContentViewVM())
}
