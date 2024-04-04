//
//  ContentView.swift
//  Moonshot
//
//  Created by kodirbek on 4/3/24.
//

import SwiftUI

struct ContentView: View {
    
    let astronaut = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        Text(String(astronaut.count))
    }
}

#Preview {
    ContentView()
}
