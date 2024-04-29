//
//  DetailView.swift
//  Bookworm
//
//  Created by kodirbek on 4/29/24.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    
    // MARK: - Properties
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingAlert = false
    
    let book: Book
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing, content: {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .fontWeight(.black)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 12)
                    .foregroundStyle(.white)
                    .background(.ultraThinMaterial)
                    .clipShape(.capsule)
                    .padding(7)
            })
            
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(book.review)
                .padding()
            
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel, action: {})
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingAlert = true
            }
        }
    }
    
    // MARK: - Methods
    private func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

// MARK: - Preview
#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Kids", review: "This was a great book!", rating: 4)
        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
