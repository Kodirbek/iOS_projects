//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by kodirbek on 4/23/24.
//

import SwiftUI

struct CheckoutView: View {
    
    // MARK: - Properties
    var order: Order
    @State private var alertTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert(alertTitle, isPresented: $showingConfirmation) {
            Button("Ok") {
                showingConfirmation = false
            }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    // MARK: - Method
    private func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        print("xx \(String(decoding: encoded, as: UTF8.self))")
        // Debugging when using break point
        // (lldb) p String(decoding: encoded, as: UTF8.self)
        
        guard let url = URL(string: "https://reqres.in/api/cupcakes") else {
            print("Invalid URL!")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _)  = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            configureSuccessAlert(order: decodedOrder)
        } catch {
            configureFailAlert(error: error)
        }
    }
    
    private func configureSuccessAlert(order: Order) {
        alertTitle = "Thank you!"
        confirmationMessage = "Your order for \(order.quantity)x \(Order.types[order.type].lowercased()) cupcakes is on its way!"
        showingConfirmation = true
    }
    
    private func configureFailAlert(error: Error) {
        alertTitle = "Sorry!"
        confirmationMessage = "Check out failed with error: \(error.localizedDescription)"
        showingConfirmation = true
    }
}

#Preview {
    CheckoutView(order: Order())
}
