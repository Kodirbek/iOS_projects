//
//  TCASampleApp.swift
//  TCASample
//
//  Created by TelosMac on 1/31/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCASampleApp: App {
    
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: TCASampleApp.store)
        }
    }
}
