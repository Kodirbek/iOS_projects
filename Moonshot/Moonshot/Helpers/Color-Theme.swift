//
//  Color-Theme.swift
//  Moonshot
//
//  Created by kodirbek on 4/8/24.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
    
    static var cardBackgroundColor: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3, opacity: 0.5)
    }
}
