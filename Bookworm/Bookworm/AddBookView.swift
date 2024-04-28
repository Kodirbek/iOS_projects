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
            ZStack(alignment: .bottomTrailing) {
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
                
                Button("Save") {
                    let newBook = Book(title: title,
                                       author: author,
                                       genre: genre,
                                       review: review,
                                       rating: rating)
                    
                    modelContext.insert(newBook)
                }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 20)
            }
            .navigationTitle("Add Book")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddBookView()
}
