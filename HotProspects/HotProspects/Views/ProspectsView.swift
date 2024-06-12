//
//  ProspectsView.swift
//  HotProspects
//
//  Created by kodirbek on 6/12/24.
//

import SwiftData
import SwiftUI

struct ProspectsView: View {
    
    // MARK: - Properties
    enum FilterType {
        case none, contacted, uncontacted
    }
    let filter: FilterType
    var title: String {
        switch filter {
            case .none:
                "Everyone"
            case .contacted:
                "Contacted people"
            case .uncontacted:
                "Uncontacted people"
        }
    }
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Text("People: \(prospects.count)")
                .navigationTitle(title)
                .toolbar {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        let prospect = Prospect(name: "Paul Hudson", emailAddress: "paul@hackingwithswift.com", isContacted: false)
                        modelContext.insert(prospect)
                    }
                }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
