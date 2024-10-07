//
//  File.swift
//  SnowSeeker
//
//  Created by Kodirbek Khamzaev on 10/8/24.
//

import SwiftUI

struct Facility: Identifiable {
    let id = UUID()
    let name: String
    
    private let icons = [
        "Accommodation": "house",
        "Beginners": "1.circle",
        "Cross-country": "map",
        "Eco-friendly": "leaf.arrow.circlepath",
        "Family": "person.3"
    ]
    
    var icon: some View {
        if let icon = icons[name] {
            Image(systemName: icon)
                .accessibilityLabel(name)
                .foregroundStyle(.secondary)
        } else {
            fatalError("Unknown facility type: \(name)")
        }
    }
}
