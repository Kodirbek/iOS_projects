//
//  AddBookView.swift
//  Bookworm
//
//  Created by kodirbek on 4/25/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var review = ""
    @State private var rating = 3
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Picker("Rating", selection: $rating) {
                        ForEach(1...5, id: \.self) {
                            Text(String($0))
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                }
                
                
            }
            .navigationTitle("Add Book")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddBookView()
}
