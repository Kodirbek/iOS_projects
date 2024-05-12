//
//  ContentView.swift
//  Instafilter
//
//  Created by kodirbek on 5/2/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State private var selectedItem: PhotosPickerItem?
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    
    // MARK: - Body
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
                        .onChange(of: filterIntensity, applyProcessing)
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
    
    
    // MARK: - Methods
    private func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    private func applyProcessing() {
        currentFilter.intensity = Float(filterIntensity)
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    private func changeFilter() {
    }
    
}


// MARK: - Preview
#Preview {
    ContentView()
}
