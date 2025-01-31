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
    var body: some Scene {
        WindowGroup {
            CounterView(store: Store(initialState: CounterFeature.State()) {
                CounterFeature()
            })
        }
    }
}
