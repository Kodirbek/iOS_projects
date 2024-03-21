//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by kodirbek on 3/21/24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State private var countries = ["Estonia",
                     "France",
                     "Germany",
                     "Ireland",
                     "Italy",
                     "Nigeria",
                     "Poland",
                     "Spain",
                     "UK",
                     "Ukraine",
                     "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    // MARK: - View
    var body: some View {
        ZStack {
            Color.customBackground
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Tap the flag of \n\(countries[correctAnswer])")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                
                ForEach(0..<3) { number in
                    Button(action: {
                        flagChosen(at: number)
                    }, label: {
                        Image(countries[number])
                            .shadow(color: .secondary, radius: 4, x: 0, y: 3)
                    })
                }
                
                Text("Current score: \(score)")
                    .font(.title3)
                    .fontWeight(.regular)
                    .fontDesign(.rounded)
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue") { askNewQuestion() }
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    // MARK: - Methods
    private func flagChosen(at number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score = (score > 0) ? (score - 1) : 0
        }
        
        showingScore = true
    }
    
    private func askNewQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
