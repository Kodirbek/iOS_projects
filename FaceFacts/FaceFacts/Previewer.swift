//
//  Previewer.swift
//  FaceFacts
//
//  Created by kodirbek on 1/1/24.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let event: Event
    let person: Person
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Person.self, configurations: config)
        
        event = Event(name: "Language Course", location: "Nonsan")
        person = Person(name: "Sam", emailAddress: "sam@test.com", details: "", metAt: event)
        
        container.mainContext.insert(person)
    }
}
