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
    
    // Properties
    var isUnlocked = true
    var selectedMapStyle: MapStyle = .hybrid
    private(set) var locations: [Location]
    var selectedPlace: Location?
    let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
    
    
    // Init (read locations from directory)
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            locations = try JSONDecoder().decode([Location].self, from: data)
        } catch {
            locations = []
        }
    }
    
    // Methods
    func addLocation(at point: CLLocationCoordinate2D) {
        let newLocation = Location(id: UUID(),
                                   name: "New location",
                                   description: "",
                                   latitude: point.latitude,
                                   longitude: point.longitude)
        locations.append(newLocation)
        save()
    }
    
    func update(location: Location) {
        guard let selectedPlace else { return }
        
        if let index = locations.firstIndex(of: selectedPlace) {
            locations[index] = location
        }
        save()
    }
    
    func remove(location: Location) {
        guard let selectedPlace else { return }
        
        if let index = locations.firstIndex(of: selectedPlace) {
            locations.remove(at: index)
        }
        save()
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(locations)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}
