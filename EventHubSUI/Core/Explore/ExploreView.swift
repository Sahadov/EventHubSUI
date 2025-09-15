//
//  ExploreView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI

struct ExploreView: View {
    @StateObject var viewModel: ExploreViewModel
    @State private var searchText = ""
    @State private var isShowingCityPicker = false
    @State private var selectedCity: LocationsList = .msk
    
    
    @State private var selectedFilter: FilterCategory? = nil
    @State private var isShowingFilterEvents = false
    
    var events = Event.events
    
    var body: some View {
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
                            
                            // Go to FilterView
                           
                        }
                        CategoryScrollView { category in
                            Task {
                                await viewModel.fetchEventsBy(category: category, location: selectedCity)
                            }
                            
                        }
                        FilterScrollView() { filter in
                            selectedFilter = filter
                            isShowingFilterEvents = true
                        }
                        .navigationDestination(isPresented: $isShowingFilterEvents) {
                            if let filter = selectedFilter {
                                switch filter {
                                case .today:
                                    SeeAllContentView(event: viewModel.todayEvents)
                                case .films:
                                    SeeAllContentView(event: viewModel.movieEvents)
                                case .list:
                                    ListContentView(events: viewModel.upcomingEvents)
                                    
                                }
                            }
                        }
                        
                        // Upcoming Events
                        
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
                                        Button {
                                            self.viewModel.goToDetail(event: event)
                                        } label: {
                                            ExploreCell(event: event, isPlaceholder: false)
                                        }
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
                                        Text("No selected events 😢")
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
                                    ForEach(viewModel.isCategoryMode ? viewModel.categoryEvents : viewModel.nearEvents, id: \.id) { event in
                                        Button {
                                            self.viewModel.goToDetail(event: event)
                                        } label: {
                                            ExploreCell(event: event, isPlaceholder: false)
                                        }
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
                        ForEach(LocationsList.allCases, id: \.self) { city in
                            Button(city.title) {
                                selectedCity = city
                                print(city)
                                Task {
                                    // сбрасываем фильтры
                                    viewModel.isCategoryMode = false
                                    viewModel.categoryEvents = []
                                    await viewModel.fetchEvents(for: city)
                                }
                            }
                        }
                        
                    } label: {
                        LocationButtonView(city: selectedCity.title)
                    }
                }
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(.bell) // заглушка
                }
                
            }
            .navigationBarHidden(true)
            .ignoresSafeArea(.keyboard)
            .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    ExploreView(viewModel: ExploreViewModel(router: Router()), events: Event.events)
}
