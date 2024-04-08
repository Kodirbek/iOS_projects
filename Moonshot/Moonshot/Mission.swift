//
//  Mission.swift
//  Moonshot
//
//  Created by kodirbek on 4/8/24.
//

import Foundation

struct Mission: Codable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchData: String?
    let crew: [CrewRole]
    let description: String
}
