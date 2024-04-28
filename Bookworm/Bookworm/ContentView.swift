//
//  ContentView.swift
//  Bookworm
//
//  Created by kodirbek on 4/24/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @Environment(\.modelContext) var modelContext
    @Query var books: [Book]
    
    @State private var showingAddScreen = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Text("Count: \(books.count)")
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Book", systemImage: "plus") {
                            showingAddScreen.toggle()
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen, content: {
                    AddBookView()
                })
        }
    }
}

#Preview {
    ContentView()
}
