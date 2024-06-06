//
//  SaveImageView.swift
//  PhotoMemos
//
//  Created by kodirbek on 6/3/24.
//

import SwiftUI

struct SaveMemoView: View {
    // MARK: - Properties
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    let locationFetcher = LocationFetcher()
    
    @State private var name = ""
    @State private var latitude: Double?
    @State private var longitude: Double?
    private var imageData: Data?
    private var downloadedImage: Image?
    
    // MARK: - Init
    init(imageData: Data?, image: Image?) {
        self.imageData = imageData
        self.downloadedImage = image
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                downloadedImage?
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 20)
                
                TextField("Name of image", text: $name)
                    .textFieldStyle(.roundedBorder)
                
                Button("Add current location", systemImage: "mappin.circle") {
                    locationFetcher.start()
                    if let location = locationFetcher.lastKnownLocation {
                        self.latitude = location.latitude
                        self.longitude = location.longitude
                    } else {
                        print("Your location is unknown")
                    }
                }
                
                Spacer()
            }
            .padding([.horizontal, .bottom])
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        let newMemo = Memo(name: name, latitude: 0.0, longitude: 0.0, imageData: imageData ?? Data())
                        modelContext.insert(newMemo)
                        dismiss()
                    }, label: {
                        Text("Save")
                    })
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

#Preview {
    SaveMemoView(imageData: Data(), image: Image(systemName: "photo"))
}
