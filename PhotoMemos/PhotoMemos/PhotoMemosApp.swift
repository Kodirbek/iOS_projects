//
//  PhotoMemosApp.swift
//  PhotoMemos
//
//  Created by kodirbek on 5/28/24.
//

import SwiftData
import SwiftUI

@main
struct PhotoMemosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Memo.self)
    }
}
