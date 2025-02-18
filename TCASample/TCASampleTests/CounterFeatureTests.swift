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
    
    @Test
    func timer() async {
        let clock = TestClock()
        
        let store = TestStore(
            initialState: CounterFeature.State(count: 0)
        ) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        await clock.advance(by: .seconds(1))
        await store.receive(\.timerTick) {
            $0.count = 1
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }
}
