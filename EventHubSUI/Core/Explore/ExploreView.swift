//
//  ExploreView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    @State private var isShowingCityPicker = false
    
    let cities = ["New York", "Los Angeles", "Moscow", "Paris", "Tokyo"]
    var events = Event.events
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                // Верхний фон
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color(.accentBlue))
                    .frame(height: 470)
                    .edgesIgnoringSafeArea(.top)
                    .offset(y: -350)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ExploreSearchBar(text: $searchText, placeholder: "Search") {
                            print("Right button tapped")
                        }
                        CategoryScrollView()
                        FilterScrollView()
                        
                        HStack {
                            Text("Upcoming Events")
                                .font(.headline)
                            Spacer()
                            Button("See All") {}
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(events, id: \.id) { event in
                                    ExploreCell(event: event)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        HStack {
                            Text("Nearby You")
                                .font(.headline)
                            Spacer()
                            Button("See All") {}
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(events, id: \.id) { event in
                                    ExploreCell(event: event)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        ForEach(cities, id: \.self) { city in
                            Button(city) {
                                // action
                            }
                        }
                        
                    } label: {
                        LocationButtonView()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(.bell)
                }
                
            }
            
        }
    }
}

#Preview {
    ExploreView(events: Event.events)
}
