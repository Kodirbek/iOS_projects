//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by kodirbek on 4/21/24.
//

import SwiftUI

struct AddressView: View {
    
    // MARK: - Properties
    @Bindable var order: Order
    
    // MARK: - Body
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip Code", text: $order.zip)
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(!order.hasValidAddress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
