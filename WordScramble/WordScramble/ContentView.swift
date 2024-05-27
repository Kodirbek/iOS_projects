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
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        .accessibilityElement()
                        .accessibilityLabel(word)
                        .accessibilityHint("\(word.count) letters")
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .toolbar {
                Button("Start over") {
                    startGame()
                    clearTableView()
                }
                    .foregroundStyle(.black)
            }
            .alert(errorTitle, isPresented: $showingError) {
                Button("Ok") { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    // MARK: - Methods
    private func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isThreeOrMoreChars(word: answer) else {
            wordError(title: "Word not long enough",
                      message: "It should be 3 or more characters!")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already",
                      message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible",
                      message: "You can't spell '\(answer)' from '\(rootWord)'")
            return
        }
        
        guard isNotRootWord(word: answer) else {
            wordError(title: "Word is not possible",
                      message: "You can't just enter the given word!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word recognized",
                      message: "You can't just make them up!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    private func startGame() {
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    private func isThreeOrMoreChars(word: String) -> Bool {
        word.count >= 3
    }
    
    private func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    private func isNotRootWord(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            }
        }
        
        return tempWord.count != 0
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, 
                            length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word,
                                                            range: range,
                                                            startingAt: 0,
                                                            wrap: false,
                                                            language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    private func clearTableView() {
        withAnimation {
            usedWords.removeAll()
        }
        newWord = ""
    }
}

#Preview {
    ContentView()
}
