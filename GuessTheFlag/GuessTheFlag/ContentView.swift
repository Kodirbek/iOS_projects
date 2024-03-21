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
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.5),
                      location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.2),
                      location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Spacer()
                
                Text("Guess the Flag")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                    .fontDesign(.rounded)
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.title3.weight(.heavy))
                            .fontDesign(.rounded)
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.bold))
                            .fontDesign(.rounded)
                    }
                    
                    ForEach(0..<3) { number in
                        Button(action: {
                            flagChosen(at: number)
                        }, label: {
                            Image(countries[number])
                                .clipShape(.rect(cornerRadius: 10))
                                .shadow(color: .primary, radius: 3, x: 0, y: 0)
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Current score: \(score)")
                    .foregroundStyle(.white)
                    .font(.subheadline.weight(.bold))
                    .fontDesign(.rounded)
                    .padding()
                    .background(Capsule().fill(.white.opacity(0.3)))
                
                Spacer()
            }
            .padding()
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
            scoreTitle = "Wrong\n That's the flag of \(countries[correctAnswer])"
            score = (score > 0) ? (score - 1) : 0
        }
        
        showingScore = true
    }
    
    private func askNewQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
