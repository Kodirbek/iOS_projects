//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Kodirbek Khamzaev on 10/17/24.
//

import SwiftUI

@Observable
class Favorites {
    private var resorts: Set<String>
    private let key = "Favorites"
    
    init() {
        // TODO: load saved data
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // TODO: save data
//        UserDefaults.standard.set(Array(resorts), forKey: key)
    }
}
