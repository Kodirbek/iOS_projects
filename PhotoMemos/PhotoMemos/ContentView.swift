//
//  ContentView.swift
//  PhotoMemos
//
//  Created by kodirbek on 5/28/24.
//

import SwiftData
import SwiftUI
import PhotosUI

struct ContentView: View {
    // MARK: - Properties
    @State private var selectedItem: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var downloadedImage: Image?
    @State private var showingAddScreen = false
    @State private var isImageUploading = false
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Memo.name)
    ]) var memos: [Memo]
    
    // MARK: - Body
    var body: some View {
        TabView {
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
                        SaveImageView(imageData: imageData, image: downloadedImage)
                    })
                }
            }
            .tabItem {
                Label("Add memo", systemImage: "photo.badge.plus")
            }
            
            NavigationStack {
                if memos.isEmpty {
                    ContentUnavailableView("No Memos",
                                           systemImage: "list.bullet",
                                           description: Text("Tap Add memo tab and create your first memo.")
                    )
                } else {
                    List {
                        ForEach(memos) { memo in
                            HStack {
                                Text(memo.name)
                                    .font(.title3)
                                
                                Spacer()
                                
                                if let uiImage = UIImage(data: memo.imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .scaledToFit()
                                }
                            }
                        }
                    }
                }
            }
            .tabItem {
                Label("Memos", systemImage: "list.bullet")
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
    ContentView()
}
