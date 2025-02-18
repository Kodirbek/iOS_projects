//
//  CounterFeature.swift
//  TCASample
//
//  Created by TelosMac on 1/31/25.
//

import SwiftUI
import ComposableArchitecture

@available(iOS 16, *)
@Reducer
struct CounterFeature {
    
    @ObservableState
    struct State: Equatable {
        var count = 0
        var fact: String?
        var isLoading = false
        var isTimerRunning = false
    }
    
    enum Action: Equatable {
        case decrementButtonTapped
        case incrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case toggleTimerButtonTapped
        case timerTick
    }
    
    enum CancelID { case  timer }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.numberFact) var numberFact
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            withAnimation {
                switch action {
                case .decrementButtonTapped:
                    state.count -= 1
                    state.fact = nil
                    return .none
                case .incrementButtonTapped:
                    state.count += 1
                    state.fact = nil
                    return .none
                case .factButtonTapped:
                    state.fact = nil
                    state.isLoading = true
                    return .run { [count = state.count] send in
                        try await send(.factResponse(numberFact.fetch(count)))
                    }
                case .factResponse(let fact):
                    state.fact = fact
                    state.isLoading = false
                    return .none
                case .toggleTimerButtonTapped:
                    state.isTimerRunning.toggle()
                    if (state.isTimerRunning) {
                        return .run { send in
                            if #available(iOS 16.0, *) {
                                for await _ in self.clock.timer(interval: .seconds(1)) {
                                    await send(.timerTick)
                                }
                            } else {
                                while true {
                                    try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
                                    await send(.timerTick)
                                }
                            }
                        }
                        .cancellable(id: CancelID.timer)
                    } else {
                        return .cancel(id: CancelID.timer)
                    }
                    
                    
                case .timerTick:
                    state.count += 1
                    state.fact = nil
                    return .none
                }
            }
        }
    }
}

