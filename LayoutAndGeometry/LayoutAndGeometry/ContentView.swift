//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by kodirbek on 7/9/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@kodirbek")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("Full name:")
                Text("KHAMZAEV KODIRBEK")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    ContentView()
}


extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}
