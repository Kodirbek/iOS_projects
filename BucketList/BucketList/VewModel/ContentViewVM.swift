//
//  ContentViewVM.swift
//  BucketList
//
//  Created by kodirbek on 5/16/24.
//

import Foundation
import CoreLocation

@Observable 
class ContentViewVM {
    private(set) var locations = [Location]()
    var selectedPlace: Location?
    
    func addLocation(at point: CLLocationCoordinate2D) {
        let newLocation = Location(id: UUID(), 
                                   name: "New location",
                                   description: "",
                                   latitude: point.latitude,
                                   longitude: point.longitude)
        locations.append(newLocation)
    }
    
    func update(location: Location) {
        guard let selectedPlace else { return }
        
        if let index = locations.firstIndex(of: selectedPlace) {
            locations[index] = location
        }
    }
}
