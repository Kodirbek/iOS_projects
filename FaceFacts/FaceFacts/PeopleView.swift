//
//  PeopleView.swift
//  FaceFacts
//
//  Created by kodirbek on 12/27/23.
//

import SwiftUI
import SwiftData

struct PeopleView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var people: [Person]
    
    
    var body: some View {
        List {
            ForEach(people) { person in
                NavigationLink(value: person) {
                    Text(person.name)
                }
            }
            .onDelete(perform: deletePerson)
        }
    }
    
    init(searchString: String = "") {
        _people = Query(filter: #Predicate { person in
            true
        })
    }
    
    func deletePerson(at offsets: IndexSet) {
        for offset in offsets {
            let person = people[offset]
            modelContext.delete(person)
        }
    }
}

#Preview {
    PeopleView()
}
