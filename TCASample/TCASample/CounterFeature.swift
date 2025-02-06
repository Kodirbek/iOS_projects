//
//  CounterFeature.swift
//  TCASample
//
//  Created by TelosMac on 1/31/25.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct CounterFeature {
    
    @ObservableState
    struct State {
        var count = 0
        var fact: String?
        var isLoading = false
        var isTimerRunning = false
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case toggleTimerButtonTapped
        case timerTick
    }
    
    enum CancelID { case  timer }
    
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
                        let (data, _) = try await URLSession.shared
                            .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                        let fact = String(decoding: data, as: UTF8.self)
                        await send(.factResponse(fact))
                    }
                case .factResponse(let fact):
                    state.fact = fact
                    state.isLoading = false
                    return .none
                case .toggleTimerButtonTapped:
                    state.isTimerRunning.toggle()
                    if (state.isTimerRunning) {
                        return .run { send in
                            while true {
                                if #available(iOS 16.0, *) {
                                    try await Task.sleep(for: .seconds(1))
                                } else {
                                    return
                                }
                                await send(.timerTick)
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

