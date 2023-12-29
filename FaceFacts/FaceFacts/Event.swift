//
//  Event.swift
//  FaceFacts
//
//  Created by kodirbek on 12/29/23.
//

import Foundation
import SwiftData

@Model
class Event {
    var name: String
    var location: String
    var people = [Person]()
    
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}
