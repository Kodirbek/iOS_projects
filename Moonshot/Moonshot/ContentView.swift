//
//  ContentView.swift
//  Moonshot
//
//  Created by kodirbek on 4/3/24.
//

import SwiftUI

struct ContentView: View {
    
    let astronaut: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let mission: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        Text(String(astronaut.count))
    }
}

#Preview {
    ContentView()
}
