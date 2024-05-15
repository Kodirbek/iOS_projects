//
//  FetchNearbyPlaces.swift
//  BucketList
//
//  Created by kodirbek on 5/15/24.
//

import SwiftUI

class FetchService {
    
    static func fetchNearbyPlaces(lat: Double, long: Double) async -> [Page]? {
        
        let urlString = getUrlString(lat: lat, long: long)
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            return items.query.pages.values.sorted { $0.title < $1.title }
        } catch {
            return nil
        }
    }
}
