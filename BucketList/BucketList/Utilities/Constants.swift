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

func getUrlString(lat: Double, long: Double) -> String {
    "https://en.wikipedia.org/w/api.php?ggscoord=\(lat)%7C\(long)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
}
