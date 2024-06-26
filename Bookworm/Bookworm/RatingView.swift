//
//  RatingView.swift
//  Bookworm
//
//  Created by kodirbek on 4/28/24.
//

import SwiftUI

struct RatingView: View {
    
    // MARK: - Properties
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    // MARK: - Body
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1...maximumRating, id: \.self) { number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
            }
        }
        .buttonStyle(.plain)
        .accessibilityElement()
        .accessibilityLabel(label)
        .accessibilityValue(rating == 1 ? "1 star" : "\(rating) stars")
        .accessibilityAdjustableAction { direction in
            switch direction {
                case .increment:
                    if rating < maximumRating { rating += 1 }
                case .decrement:
                    if rating > 1 { rating -= 1 }
                default:
                    break
            }
        }
    }
    
    // MARK: - Method
    private func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(3))
}
