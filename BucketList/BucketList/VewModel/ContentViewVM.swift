//
//  ContentViewVM.swift
//  BucketList
//
//  Created by kodirbek on 5/16/24.
//

import Foundation

protocol ContentViewVMProtocol {
    var locations: [Location] { get }
    var selectedPlace: Location? { get }
}

@Observable 
class ContentViewVM: ContentViewVMProtocol {
    var locations = [Location]()
    var selectedPlace: Location?
}
