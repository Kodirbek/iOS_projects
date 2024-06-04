//
//  ContentView.swift
//  PhotoMemos
//
//  Created by kodirbek on 5/28/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Memo.name)
    ]) var memos: [Memo]
    
    // MARK: - Body
    var body: some View {
        TabView {
            AddMemoView()
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
    
    
}

#Preview {
    ContentView()
}
