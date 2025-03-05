import SwiftUI
import ComposableArchitecture

@available(iOS 16, *)
struct CounterView: View {
    
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack() {
                Text("\(store.count)")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                    .scaleEffect(store.isLoading ? 0.8 : 1.0)
                    .animation(.spring(duration: 0.25, bounce: 0.3), value: store.count)
                
                HStack {
                    Button("-") {
                        store.send(.decrementButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                    
                    Button("+") {
                        store.send(.incrementButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                }
                
                Button(store.isTimerRunning ? "Stop timer" : "Start timer") {
                    store.send(.toggleTimerButtonTapped)
                }
                .font(.title)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                
                Button("Fact") {
                    store.send(.factButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                
                if store.isLoading {
                    ProgressView()
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.25), value: store.isLoading)
                } else if let fact = store.fact {
                    Text(fact)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding()
                        .transition(.opacity)
                        .animation(.spring(duration: 3, bounce: 0.3), value: store.fact)
                }
            }
        }
    }
}

#Preview {
    if #available(iOS 16, *) {
        CounterView(store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        })
    } else {
        // Fallback on earlier versions
    }
}
