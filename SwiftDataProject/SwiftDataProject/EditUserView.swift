//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by kodirbek on 5/1/24.
//

import SwiftUI
import SwiftData

struct EditUserView: View {
    
    @Bindable var user: User
    
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let user = User(name: "Test User", city: "Test City", joinDate: .now)
        return EditUserView(user: user)
            .modelContainer(container)
    } catch {
        return Text("Failed to temporary create container: \(error.localizedDescription)")
    }
}
