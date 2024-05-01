//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by kodirbek on 4/30/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
