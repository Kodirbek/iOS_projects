//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by kodirbek on 4/14/24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State private var order = Order()
    
    // MARK: - Body
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    
    // MARK: - Methods
    
    
}

#Preview {
    ContentView()
}
