//
//  CustomAnnotationMark.swift
//  BucketList
//
//  Created by kodirbek on 5/15/24.
//

import SwiftUI

struct CustomAnnotationMark: View {
    
    @Binding var selectedPlace: Location?
    var location: Location
    
    var body: some View {
        Image(systemName: "mappin.and.ellipse")
            .imageScale(.large)
            .foregroundStyle(.black)
            .shadow(color: .white, radius: 8, x: 4, y: 0)
            .onLongPressGesture {
                selectedPlace = location
            }
    }
}

#Preview {
    CustomAnnotationMark(selectedPlace: .constant(.example), location: .example)
}
