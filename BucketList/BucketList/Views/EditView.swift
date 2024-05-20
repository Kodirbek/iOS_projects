//
//  EditView.swift
//  BucketList
//
//  Created by kodirbek on 5/14/24.
//

import SwiftUI

struct EditView: View {
    
    
    // MARK: - Properties
    @Environment(\.dismiss) var dismiss
    var location: Location
    var onSave: (Location) -> Void
    var onDelete: (Location) -> Void
    
    @State private var name: String
    @State private var description: String
    
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    
    // MARK: - Init
    init(
        location: Location,
        onSave: @escaping (Location) -> Void,
        onDelete: @escaping (Location) -> Void) {
            self.location = location
            self.onSave = onSave
            self.onDelete = onDelete
            
            _name = State(initialValue: location.name)
            _description = State(initialValue: location.description)
        }
    
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $name)
                        .autocorrectionDisabled()
                    TextField("Description", text: $description)
                        .autocorrectionDisabled()
                }
                
                Section {
                    Button("Remove", role: .destructive) {
                        onDelete(location)
                        dismiss()
                    }
                }
                
                Section("Nearby…") {
                    switch loadingState {
                        case .loaded:
                            ForEach(pages, id: \.pageid) { page in
                                Text(page.title)
                                    .font(.headline)
                                + Text(": ") +
                                Text(page.description)
                                    .italic()
                            }
                        case .loading:
                            Text("Loading…")
                        case .failed:
                            Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                if let pages = await FetchService.fetchNearbyPlaces(
                    lat: location.latitude,
                    long: location.longitude) {
                    self.pages = pages
                    loadingState = .loaded
                } else {
                    loadingState = .failed
                }
            }
        }
    }
}


// MARK: - Preview
#Preview {
    EditView(location: .example) { _ in } onDelete: { _ in }
}
