//
//  Memo.swift
//  PhotoMemos
//
//  Created by kodirbek on 5/29/24.
//

import CoreLocation
import Foundation
import SwiftData

@Model
class Memo {
    var name: String
    var latitude: Double
    var longitude: Double
    @Attribute(.externalStorage) var imageData: Data
    
    init(name: String,
         latitude: Double,
         longitude: Double,
         imageData: Data)
    {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.imageData = imageData
    }
    
    var location: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }
}
