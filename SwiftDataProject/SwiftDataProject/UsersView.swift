//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by kodirbek on 5/3/24.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    
    // MARK: - Properties
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    // MARK: - Init
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
    
    // MARK: - Body
    var body: some View {
        List(users) { user in
            HStack {
                Text(user.name)
                Spacer()
                Text(String(user.jobs.count))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .font(.caption)
            }
        }
        .onAppear(perform: addSample)
    }
    
    // MARK: - Methods
    func addSample() {
        let user1 = User(name: "Piper Chapman", city: "New York", joinDate: .now)
        let job1 = Job(name: "Organize sock drawer", priority: 3)
        let job2 = Job(name: "Make plans with Alex", priority: 4)
        
        modelContext.insert(user1)
        
        user1.jobs.append(job1)
        user1.jobs.append(job2)
    }
}

// MARK: - Preview
#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
