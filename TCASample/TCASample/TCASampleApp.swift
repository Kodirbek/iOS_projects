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
    
    @available(iOS 16, *)
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16, *) {
                CounterView(store: TCASampleApp.store)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
