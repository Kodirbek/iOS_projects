//
//  ContentView.swift
//  Instafilter
//
//  Created by kodirbek on 5/2/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var blurAmount = 0.0
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .blur(radius: blurAmount)
            Text("Hello, world!")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
            
            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
