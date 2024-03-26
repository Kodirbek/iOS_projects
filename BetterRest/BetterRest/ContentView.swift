//
//  ContentView.swift
//  BetterRest
//
//  Created by kodirbek on 3/25/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    static private var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    private var bedtime: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(hour + minute), estimatedSleep: Double(sleepAmount), coffee: Int64(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "There was a problem calculating your bedtime."
        }
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Form {
                    Section("When do you want to wake up?") {
                        DatePicker("Please enter a time",
                                   selection: $wakeUp,
                                   displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(.wheel)
                    }
                    
                    Section("Desired amount of sleep") {
                        Stepper("\(sleepAmount.formatted()) hours",
                                value: $sleepAmount,
                                in: 4...12,
                                step: 0.25)
                    }
                    
                    Section {
                        Picker("Daily coffee intake",
                               selection: $coffeeAmount) {
                            ForEach(1...20,
                                    id: \.self) {
                                Text("^[\($0) cup](inflect: true)")
                            }
                        }.pickerStyle(.navigationLink)
                    }
                }
                
                VStack(alignment: .center) {
                    Text("Your ideal bedtime is")
                        .foregroundStyle(.secondary)
                        .font(.title3.weight(.heavy))
                        .fontDesign(.rounded)
                    
                    Text(bedtime)
                        .font(.largeTitle.weight(.bold))
                        .fontDesign(.rounded)
                }
                
                Spacer()
            }
            .navigationTitle("BetterRest")
        }
    }
}

#Preview {
    ContentView()
}
