//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by kodirbek on 7/9/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .trailing) {
            ForEach(0..<10) {position in
                Text("Number \(position)")
                    .alignmentGuide(.trailing) { _ in
                        Double(position) * -10
                    }
            }
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
    }
}

#Preview {
    ContentView()
}
