//
//  ExploreView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI

struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()
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
                // SearchBar
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ExploreSearchBar(text: $searchText, placeholder: "Search") {
                            /// Сброс фильтров по умолчанию
                            Task {
                                viewModel.resetToDefault()
                                await viewModel.fetchInitialEvents()
                            }
                        }
                        CategoryScrollView { category in
                            Task {
                                await viewModel.fetchEventsBy(category: category)
                            }
                        }
                        FilterScrollView() { filter in
                            viewModel.fetchEventsBy(filter: filter)
                        }
                        
                        HStack {
                            Text("Upcoming Events")
                                .font(.headline)
                            Spacer()
                            Button("See All") {
                                // Go to seeAll view or eventsView ?
                            }
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                if viewModel.isLoading {
                                    // 3 фиктивных элемента skeleton
                                    ForEach(0..<3, id: \.self) { _ in
                                        ExploreCell(event: .mockConcert, isPlaceholder: true)
                                    }
                                } else {
                                    ForEach(viewModel.isCategoryMode ? viewModel.categoryEvents : viewModel.upcomingEvents, id: \.id) { event in
                                        NavigationLink(destination: EventDetailsView(event: event)) {
                                            ExploreCell(event: event, isPlaceholder: false)
                                        }
                                        .buttonStyle(.plain) // убираем подсветку ссылки
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        HStack {
                            Text("Nearby You")
                                .font(.headline)
                            Spacer()
                            Button("See All") {
                                // Go to seeAll view or eventsView ?
                            }
                        }
                        .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                if viewModel.isLoading {
                                    // Skeleton
                                    ForEach(0..<3, id: \.self) { _ in
                                        ExploreCell(event: .mockConcert, isPlaceholder: true)
                                    }
                                } else if viewModel.isCategoryMode && viewModel.categoryEvents.isEmpty {
                                    // Пустое состояние для фильтра FREE
                                    VStack(spacing: 8) {
                                        Text("No free events 😢")
                                            .font(.headline)
                                            .foregroundColor(.gray)
                                        Text("Try another category or date")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(width: UIScreen.main.bounds.width - 32, height: 200)
                                    .padding()
                                } else {
                                    // Список событий
                                    ForEach(viewModel.isCategoryMode ? viewModel.categoryEvents : viewModel.upcomingEvents, id: \.id) { event in
                                        NavigationLink(destination: EventDetailsView(event: event)) {
                                            ExploreCell(event: event, isPlaceholder: false)
                                        }
                                        .buttonStyle(.plain)
                                    }
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
                                print(city)
                            }
                        }
                        
                    } label: {
                        LocationButtonView()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(.bell) // заглушка
                }
                
            }
            
        }
    }
}

#Preview {
    ExploreView(events: Event.events)
}
