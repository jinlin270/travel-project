//
//  MapView.swift
//  travel
//
//  Created by Lin Jin on 1/21/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, interactionModes: .all, showsUserLocation: true)
            .onAppear {
                if let userLocation = locationManager.userLocation {
                    viewModel.updateRegion(center: userLocation)
                }
            }
            .edgesIgnoringSafeArea(.all)
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
