//
//  Constants.swift
//  BucketList
//
//  Created by kodirbek on 5/15/24.
//

import SwiftUI
import MapKit


let startPosition = MapCameraPosition.region(
    MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5519, longitude: 126.9918),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
)
