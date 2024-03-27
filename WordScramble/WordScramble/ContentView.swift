//
//  ContentView.swift
//  WordScramble
//
//  Created by kodirbek on 3/27/24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        Text(word)
                    }
                }
            }
            .navigationTitle(rootWord)
        }
    }
    
    // MARK: - Methods
}

#Preview {
    ContentView()
}
