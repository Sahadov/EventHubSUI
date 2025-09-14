//
//  MapView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @ObservedObject var viewModel = MapViewModel()
    
    var body: some View {
        ZStack {
            mapView
            searchBar
            gradientView
            bottomCard
        }
        .padding(.bottom, 30)
        .onAppear {
            let manager = CLLocationManager()
            manager.requestWhenInUseAuthorization()
            if let coord = manager.location?.coordinate {
                viewModel.currentLocation = coord
            }
        }
    }
    
    
    var mapView: some View {
        Map(coordinateRegion: $viewModel.mapRegion,
            annotationItems: viewModel.upcomingEvents.compactMap { event in
                event.coordinates != nil ? event : nil
            }) { event in
            MapAnnotation(coordinate: event.coordinates!) {
                VStack(spacing: 0) {
                    ZStack {
                        // внешний белый квадрат
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .frame(width: 44, height: 44)
                            .shadow(radius: 5)
                        
                        // внутренний цветной квадрат с цветом категории
                        if let category = EventCategory(rawValue: event.categories?.first ?? "concert") {
                            RoundedRectangle(cornerRadius: 6)
                            .fill(category.color)
                            .frame(width: 30, height: 30)
                                        
                        // иконка из категории
                        Image(systemName: category.iconName)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width: 18, height: 18)
                        } else {
                        // на случай некорректного значения
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.customYellow)
                            .frame(width: 30, height: 30)
                                        
                            Image(systemName: "mappin")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 18, height: 18)
                        }
                    }
                    
                    Image(systemName: "triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: 10, height: 10)
                        .rotationEffect(Angle(degrees: 180))
                        .offset(y: -3)
                        .padding(.bottom, 40)
                }
                .onTapGesture {
                    withAnimation(.spring) {
                        viewModel.tappedEvent = event
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
                    
                    TextField("Find food or restaurant", text: $viewModel.searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding(.vertical, 14)
                .padding(.horizontal)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 3)
                
                Button(action: {
                    if let coord = viewModel.currentLocation {
                        withAnimation(.easeInOut) {
                            MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude),
                                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                            )
                        }
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(radius: 3)
                        
                        Image(systemName: "scope")
                            .foregroundColor(.accentBlue)
                    }
                    .frame(width: 50, height: 50)
                }
            }
            .padding(.horizontal)
            .padding(.top, 30)
            
            CategoryScrollView(screenType: .map)
            
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
            
            if let tappedEvent = viewModel.tappedEvent {
                EventCard(type: .favourites,
                          event: tappedEvent,
                          isFavourite: viewModel.isFavorite(tappedEvent)
                    ){
                        viewModel.toggleFavorite(tappedEvent)
                    }
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
