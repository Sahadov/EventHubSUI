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
    @State var searchText: String = ""
    
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.7569, longitude: 37.6151),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    @State private var tappedEvent: Event?
    
    var body: some View {
        ZStack {
            mapView
            searchBar
            gradientView
            bottomCard
        }
        .padding(.bottom, 50)
    }
    
    var mapView: some View {
        Map(coordinateRegion: $mapRegion,
            annotationItems: viewModel.upcomingEvents.compactMap { event in
                event.coordinates != nil ? event : nil
            }) { event in
            MapAnnotation(coordinate: event.coordinates!) {
                VStack {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)
                        .scaleEffect(tappedEvent?.id == event.id ? 1.2 : 1)
                    
                    Text(event.title ?? "Без названия")
                        .font(.caption)
                        .fixedSize()
                }
                .onTapGesture {
                    withAnimation(.spring) {
                        tappedEvent = event
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
    
    var searchBar: some View {
        VStack {
            HStack(spacing: 12) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.accentBlue)
                    
                    TextField("Find food or restaurant", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding(.vertical, 14)
                .padding(.horizontal)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 3)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(radius: 3)
                    
                    Image(systemName: "scope")
                        .foregroundColor(.accentBlue)
                }
                .frame(width: 50, height: 50)
            }
            .padding(.horizontal)
            .padding(.top, 30)
            
            Spacer()
        }
    }
    
    var gradientView: some View {
        VStack {
            Spacer()
            
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.4), Color.clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: 200)
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    var bottomCard: some View {
        VStack {
            Spacer()
            
            if let tappedEvent {
                EventCard(type: .favourites, event: tappedEvent)
                    .shadow(radius: 5)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 40)
            }
        }
    }
    
}

#Preview {
    MapView()
}
