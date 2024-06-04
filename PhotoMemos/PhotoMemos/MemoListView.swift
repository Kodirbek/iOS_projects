//
//  MemoListView.swift
//  PhotoMemos
//
//  Created by kodirbek on 6/4/24.
//

import SwiftData
import SwiftUI

struct MemoListView: View {
    // MARK: - Property
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Memo.name)
    ]) var memos: [Memo]
    
    // MARK: - Body
    var body: some View {
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
                .scrollBounceBehavior(.basedOnSize)
            }
        }
    }
}

#Preview {
    MemoListView()
}
