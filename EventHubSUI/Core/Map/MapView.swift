//
//  MapView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var viewModel = MapViewModel()
    
    @State private var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.7569, longitude: 37.6151), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion,
                annotationItems: viewModel.upcomingEvents) { event in
                if let coords = event.coordinates {
                    MapAnnotation(coordinate: coords) {
                        VStack {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                            Text(event.title ?? "Без названия")
                                .font(.caption)
                                .fixedSize()
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    MapView()
}
