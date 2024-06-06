//
//  AddMemoView.swift
//  PhotoMemos
//
//  Created by kodirbek on 6/4/24.
//

import SwiftUI
import PhotosUI

struct AddMemoView: View {
    // MARK: - Properties
    @State private var selectedItem: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var downloadedImage: Image?
    @State private var showingAddScreen = false
    @State private var isImageUploading = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack(alignment: .center) {
                if isImageUploading {
                    ProgressView("Loading")
                        .controlSize(.large)
                    
                }
                
                VStack {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        ContentUnavailableView("Import photo",
                                               systemImage: "photo.badge.plus",
                                               description: Text("Tap to import a photo.")
                        )
                    }
                    .onChange(of: selectedItem, loadImage)
                    
                    Spacer()
                }
                .padding([.horizontal, .bottom])
                .sheet(isPresented: $showingAddScreen, content: {
                    SaveMemoView(imageData: imageData, image: downloadedImage)
                })
            }
        }
    }
    
    // MARK: - Methods
    private func loadImage() {
        Task {
            isImageUploading = true
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            self.downloadedImage = Image(uiImage: inputImage)
            self.imageData = imageData
            showingAddScreen.toggle()
            isImageUploading = false
        }
    }
}

#Preview {
    AddMemoView()
}
