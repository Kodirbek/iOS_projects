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
            Text(user.name)
        }
    }
}

// MARK: - Preview
#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
