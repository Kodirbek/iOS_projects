//
//  ContentView.swift
//  PhotoMemos
//
//  Created by kodirbek on 5/28/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AddMemoView()
                .tabItem {
                    Label("Add memo", 
                          systemImage: "photo.badge.plus")
                }
            
            MemoListView()
                .tabItem {
                    Label("Memos", 
                          systemImage: "list.bullet")
                }
        }
    }
    
    
}

#Preview {
    ContentView()
}
