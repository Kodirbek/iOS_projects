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
    @State private var viewModel: ContentViewVM
    
    init(viewModel: ContentViewVM) {
        self.viewModel  = viewModel
    }
    
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isUnlocked {
                    MapReader { proxy in
                        MapView(proxy: proxy,
                                viewModel: viewModel)
                    }
                } else {
                    CustomContentUnavailableView(onTryAgain: {
                        Task {
                            viewModel.isUnlocked = await Authenticator.authenticate()
                        }
                    })
                }
            }
            .navigationTitle("Bucket list")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Menu {
                    ForEach(MapStyle.allCases, id: \.self) { style in
                        Button(action: {
                            viewModel.changeMapStyle(to: style)
                        }) {
                            Text(style.rawValue)
                        }
                    }
                } label: {
                    Text("Map Style")
                        .font(.system(size: 15))
                }
            }
        }
        .onAppear {
            Task {
                viewModel.isUnlocked = await Authenticator.authenticate()
            }
        }
        
    }
    
}

// MARK: - Preview
#Preview {
    ContentView(viewModel: ContentViewVM())
}
