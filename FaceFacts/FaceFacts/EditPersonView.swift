//
//  EditPersonView.swift
//  FaceFacts
//
//  Created by kodirbek on 12/25/23.
//

import SwiftData
import SwiftUI

struct EditPersonView: View {
    
    @Bindable var person: Person
    
    @Query(sort: [
        SortDescriptor(\Event.name),
        SortDescriptor(\Event.location)
    ]) var events: [Event]
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $person.name)
                    .textContentType(.name)
                
                TextField("Email address", text: $person.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            
            Section("Notes") {
                TextField("Details about this person", text: $person.details, axis: .vertical)
            }
        }
        .navigationTitle("Edit Person")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addEvent() {
        
    }
}

//#Preview {
//    EditPersonView()
//}
