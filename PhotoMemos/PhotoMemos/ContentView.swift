//
//  ContentView.swift
//  PhotoMemos
//
//  Created by kodirbek on 5/28/24.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    // MARK: - Properties
    @State private var selectedItem: PhotosPickerItem?
    @State private var downloadedImage: Image?
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    if let downloadedImage {
                        downloadedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture",
                                               systemImage: "photo.badge.plus",
                                               description: Text("Tap to import a photo.")
                        )
                    }
                }
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
            }
            .padding([.horizontal, .bottom])
        }
    }
    
    // MARK: - Methods
    private func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            downloadedImage = Image(uiImage: inputImage)
        }
    }
}

#Preview {
    ContentView()
}
