//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by kodirbek on 4/14/24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State private var order = Order()
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                } // Section
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                            .transition(.opacity)
                        
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                            .transition(.opacity)
                    }
                } // Section
                
                Section {
                    NavigationLink("Delivery details") {
                        AddressView(order: order)
                    }
                }
            }
            .animation(.default, value: order.specialRequestEnabled)
            .navigationTitle("Cupcake Corner")
        }
    }
    
    // MARK: - Methods
    
    
}

#Preview {
    ContentView()
}
