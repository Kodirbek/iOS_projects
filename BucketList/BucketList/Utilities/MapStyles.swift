//
//  MapStyles.swift
//  BucketList
//
//  Created by kodirbek on 5/20/24.
//

import SwiftUI
import MapKit

enum MapStyle: String, CaseIterable {
    case hybrid = "Hybrid"
    case imagery = "Imagery"
    case standard = "Standard"
    
    var mapStyle: _MapKit_SwiftUI.MapStyle {
        switch self {
            case .hybrid:
                return .hybrid(elevation: .realistic)
            case .imagery:
                return .imagery(elevation: .realistic)
            case .standard:
                return .standard(elevation: .realistic)
        }
    }
}
