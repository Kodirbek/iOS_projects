import ComposableArchitecture
import Testing
@testable import TCASample

@MainActor
struct TCASampleTests {
    @Test
    func basics() async {
        let store = TestStore(
            initialState: CounterFeature.State(count: 0)
        ) {
            CounterFeature()
        }
        
        
        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
        
        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }
    }
}
