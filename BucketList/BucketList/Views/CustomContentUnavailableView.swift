//
//  CustomContentUnavailableView.swift
//  BucketList
//
//  Created by kodirbek on 5/15/24.
//

import SwiftUI

struct CustomContentUnavailableView: View {
    var onTryAgain: () -> Void
    
    var body: some View {
        ContentUnavailableView {
            Label("Authentication failed!", systemImage: "map.fill")
        } description: {
            Text("Map will be presented once authentication is successful.")
        } actions: {
            Button("Try Again") {
                onTryAgain()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    CustomContentUnavailableView() { }
}
