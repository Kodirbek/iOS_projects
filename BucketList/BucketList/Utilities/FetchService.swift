//
//  FetchNearbyPlaces.swift
//  BucketList
//
//  Created by kodirbek on 5/15/24.
//

import SwiftUI

class FetchService {
    
    static func fetchNearbyPlaces(lat: Double, long: Double) async -> [Page]? {
        
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(lat)%7C\(long)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
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
