//
//  MapModel.swift
//  travel
//
//  Created by Lin Jin on 1/21/25.
//

import SwiftUI
import MapKit

class MapViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion
    
    init() {
        // Default to a starting region
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // San Francisco as an example
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }
    
    func updateRegion(center: CLLocationCoordinate2D) {
        region.center = center
    }
}
