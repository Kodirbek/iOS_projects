//
//  Memo.swift
//  PhotoMemos
//
//  Created by kodirbek on 5/29/24.
//

import Foundation
import SwiftData

@Model
class Memo {
    var name: String
    var imageData: Data
    
    init(name: String, imageData: Data) {
        self.name = name
        self.imageData = imageData
    }
}
