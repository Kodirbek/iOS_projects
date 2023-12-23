//
//  FaceFactsApp.swift
//  FaceFacts
//
//  Created by kodirbek on 12/23/23.
//

import SwiftUI
import SwiftData

@main
struct FaceFactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
