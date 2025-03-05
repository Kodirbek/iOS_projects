import SwiftUI
import ComposableArchitecture

@main
struct TCASampleApp: App {
    
    @available(iOS 16, *)
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16, *) {
                AppView(store: TCASampleApp.store)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
