//
//  BookwormApp.swift
//  Bookworm
//
//  Created by kodirbek on 4/24/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
