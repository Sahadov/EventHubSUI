//
//  MapView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.7569, longitude: 37.6151), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    MapView()
}
