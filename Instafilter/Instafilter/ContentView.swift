//
//  ContentView.swift
//  Instafilter
//
//  Created by kodirbek on 5/2/24.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture",
                                               systemImage: "photo.badge.plus",
                                               description: Text("Tap to import a photo")
                        )
                    }
                }
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter", 
                           action: changeFilter)
                    
                    Spacer()
                    
                    // share the picture
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            // more code to come
            processedImage = Image(uiImage: inputImage)
        }
    }
    
    func changeFilter() {
    }
    
}

#Preview {
    ContentView()
}
