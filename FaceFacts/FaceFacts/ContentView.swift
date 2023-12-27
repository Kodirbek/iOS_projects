//
//  ContentView.swift
//  FaceFacts
//
//  Created by kodirbek on 12/23/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var path = [Person]()
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            PeopleView(searchString: searchText)
                .navigationTitle("FaceFacts")
                .navigationDestination(for: Person.self) { person in
                    EditPersonView(person: person)
                }
                .toolbar {
                    Button("Add person", systemImage: "plus", action: addPerson)
                }
                .searchable(text: $searchText)
        }
    }
    
    func addPerson() {
        let person = Person(name: "", emailAddress: "", details: "")
        modelContext.insert(person)
        path.append(person)
    }
    
    
}

#Preview {
    ContentView()
}
