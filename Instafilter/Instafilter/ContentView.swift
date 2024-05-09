//
//  ContentView.swift
//  Instafilter
//
//  Created by kodirbek on 5/2/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    
    @State private var image: Image?
    
    var body: some View {
        VStack {
            if image != nil {
                image?
                    .resizable()
                    .scaledToFit()
            } else {
                ContentUnavailableView("No Image",
                                       systemImage: "person",
                                       description: Text("There is no image yet")
                )
            }
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        let inputImage = UIImage(resource: .singapore)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = beginImage
        let amount = 1.0
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(amount/2, forKey: kCIInputIntensityKey)}
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 10, forKey: kCIInputRadiusKey)}
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 5, forKey: kCIInputScaleKey)}
        
        guard let outputImage = currentFilter.outputImage,
              let cgImage = context.createCGImage(outputImage,
                                                  from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
