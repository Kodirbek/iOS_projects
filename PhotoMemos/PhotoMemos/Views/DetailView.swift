//
//  DetailView.swift
//  PhotoMemos
//
//  Created by kodirbek on 6/4/24.
//

import SwiftUI

struct DetailView: View {
    // MARK: - Properties
    private var memo: Memo
    
    // MARK: - Init
    init(memo: Memo) {
        self.memo = memo
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            if let uiImage = UIImage(data: memo.imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }
        }
        .navigationTitle(memo.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(memo: Memo(name: "sample name", imageData: Data()))
}
