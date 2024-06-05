//
//  SaveImageView.swift
//  PhotoMemos
//
//  Created by kodirbek on 6/3/24.
//

import SwiftUI

struct SaveImageView: View {
    // MARK: - Properties
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
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
    SaveImageView(imageData: Data(), image: Image(systemName: "photo"))
}
