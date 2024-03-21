//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by kodirbek on 3/21/24.
//

import SwiftUI

struct ContentView: View {
    
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            Color.teal
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Tap the flag of \n\(countries[correctAnswer])")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.primary)
                
                ForEach(0..<3) { number in
                    Button(action: {
                        // flag was tapped
                    }, label: {
                        Image(countries[number])
                            .shadow(color: .secondary, radius: 4, x: 0, y: 3)
                    })
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
