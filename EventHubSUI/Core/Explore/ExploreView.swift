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
    @State private var isFiltersAppear: Bool = false
    @State private var selectedCity: LocationsList = .msk
    
    var events = Event.events
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color(hex: "#f9f9fb")
            ZStack(alignment: .top) {
                ExploreToolBar(viewModel: viewModel, selectedCity: $selectedCity)
                
                ScrollView(.vertical, showsIndicators: false) {
                    ZStack(alignment: .top) {
                        Background()
                        
                        VStack(spacing: 0) {
                            Spacer().frame(height: 110)
                            
                            ExploreSearchBar(
                                text: $searchText,
                                placeholder: "Search",
                                asButton: true,
                                onRightButtonTap: {
                                    isFiltersAppear = true

                                },
                                onTapSearchBar: {
                                    viewModel.goToSeach(viewModel.upcomingEvents)
                                }
                            )
                       
                            
                            ExploreCategoryView(viewModel: viewModel, selectedCity: selectedCity)
                            
                            ExploreFilterView(viewModel: viewModel)
                            
                            EventTitle(title: "Upcoming Events", viewModel: viewModel, events: viewModel.upcomingEvents)
                            
                            HorizontalEventListView(viewModel: viewModel, events: viewModel.upcomingEvents)
                            
                            EventTitle(title: "Nearby You", viewModel: viewModel, events: viewModel.nearEvents)
                            
                            HorizontalEventListView(viewModel: viewModel, events: viewModel.nearEvents)
                        }
                        .padding(.vertical)
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
            .sheet(isPresented: $isFiltersAppear) {
                FilterView(isPresented: $isFiltersAppear)  { preferences in
                    
                    Task {
                        await viewModel.fetchEvents(by: preferences)
                    }
                    
                }
            }
        }
        .onAppear {
            selectedCity = viewModel.currentLocation
        }
        .onChange(of: viewModel.currentLocation) { newValue in
            selectedCity = newValue
        }
    }
}

// MARK: - Subviews

private struct Background: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .fill(Color(hex: "#4a43ec"))
            .frame(height: 400)
            .offset(y: -190)
    }
}

private struct ExploreToolBar: View {
    @ObservedObject var viewModel: ExploreViewModel
    @Binding var selectedCity: LocationsList
    
    var body: some View {
        HStack {
            // Кнопка выбора города
            Menu {
                ForEach(LocationsList.allCases, id: \.self) { city in
                    Button(city.title) {
                        selectedCity = city
                        Task {
                            // Обновляем события при смене города
                            viewModel.updateCurrentLocation(location: city)
                            viewModel.isCategoryMode = false
                            viewModel.categoryEvents = []
                            print(city)
                            print(city)
                            print(city)
                            print(city)
                            print(city)
                            await viewModel.fetchInitialEvents(city)
                        }
                    }
                }
            } label: {
                LocationButtonView(city: selectedCity.title)
            }
            
            Spacer()
            
            Button() {
//TODO: Переход на Notification
        
                viewModel.goToNotification()
        
    } label: {
        Image(.bell)
    }
 
        }
        .padding()
        .foregroundColor(.white)
        .padding(.top, UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first?.safeAreaInsets.top ?? 0)
        .background(Color(hex: "#4a43ec"))
        .zIndex(1)
        
    }
}

private struct EventTitle: View {
    let title: String
    @ObservedObject var viewModel: ExploreViewModel
    let events: [Event]
    
    var body: some View {
        HStack {
            Text(title)
                .font(.Airbnb.medium(size: 18))
                .foregroundStyle(Color(hex: "#383449"))
            Spacer()
            Button("See All") {
                viewModel.goToSeeAll(viewModel.categoryEvents, viewModel.isLoading)

            }
            .foregroundStyle(Color(hex: "#747688"))
        }
        .padding(.horizontal, 20)
        
    }
        
}

private struct ExploreCategoryView: View {
    @ObservedObject var viewModel: ExploreViewModel
    let selectedCity: LocationsList
    
    var body: some View {
        CategoryScrollView { category in
            Task {
                if category == .all {
                    await viewModel.resetToDefault(selectedCity)
                } else {
                    await viewModel.fetchEventsBy(category: category, location: selectedCity)
                }
            }
        }
        Spacer(minLength: 30)
    }
}

private struct ExploreFilterView: View {
    @ObservedObject var viewModel: ExploreViewModel
    
    var body: some View {
        FilterScrollView { filter in
            switch filter {
            case .today:
                viewModel.goToSeeFilter(viewModel.todayEvents, viewModel.isLoading)
            case .films:
                viewModel.goToSeeFilter(viewModel.movieEvents, viewModel.isLoading)
            case .list:
                viewModel.goToList(viewModel.upcomingEvents)
            }
        }
        Spacer(minLength: 20)
    }
}

private struct HorizontalEventListView: View {
    @ObservedObject var viewModel: ExploreViewModel
    let events: [Event]
    var showEmptyState: Bool = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                if viewModel.isLoading {
                    ForEach(0..<3, id: \.self) { _ in
                        ExploreCell(event: .mockConcert, isPlaceholder: true, isBookmarked: false)
                    }
                } else {
                    ForEach(viewModel.isCategoryMode ? viewModel.categoryEvents : events, id: \.id) { event in
                        Button {
                            viewModel.goToDetail(event: event)
                        } label: {
                            ExploreCell(
                                event: event,
                                isPlaceholder: false,
                                isBookmarked: viewModel.isFavorite(event), // <-- статус берём из Realm
                                onBookmarkTap: {
                                    viewModel.toggleFavorite(event)
                                }
                            )
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 5)
        }
    }
}





#Preview {
    ExploreView(viewModel: ExploreViewModel(router: Router()), events: Event.events)
}
