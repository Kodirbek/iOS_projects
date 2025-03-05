import SwiftUI
import ComposableArchitecture

@available(iOS 16, *)
struct AppView: View {
    
    let store: StoreOf<AppFeature>
    
    var body: some View {
        TabView {
            CounterView(store: store.scope(state: \.tab1, action: \.tab1))
                .tabItem {
                    Text("Counter 1")
                }
            
            CounterView(store: store.scope(state: \.tab2, action: \.tab2))
                .tabItem {
                    Text("Counter 2")
                }
        }
    }
}

#Preview {
    if #available(iOS 16, *) {
        AppView(store: Store(initialState: AppFeature.State()) {
            AppFeature()
        })
    } else {
        // Fallback on earlier versions
    }
}
