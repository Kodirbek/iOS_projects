//
//  Location.swift
//  BucketList
//
//  Created by kodirbek on 5/14/24.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
}
