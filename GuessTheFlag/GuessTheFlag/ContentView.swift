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
            LinearGradient(colors: [.teal, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.title3.weight(.heavy))
                        .fontDesign(.rounded)
                    
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.bold))
                        .fontDesign(.rounded)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        flagChosen(at: number)
                    }, label: {
                        Image(countries[number])
                            .clipShape(.rect(cornerRadius: 10))
                            .shadow(color: .white, radius: 3, x: 0, y: 0)
                    })
                }
                
                Text("Current score: \(score)")
                    .foregroundStyle(.white)
                    .font(.subheadline.weight(.bold))
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
