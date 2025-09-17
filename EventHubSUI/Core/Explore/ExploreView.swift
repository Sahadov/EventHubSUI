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
    
    
    var events = Event.events
    
    var body: some View {
        ZStack(alignment: .top) {
            ExploreToolBar(viewModel: viewModel, selectedCity: $selectedCity)
            
            ScrollView(.vertical, showsIndicators: false) {
                ZStack(alignment: .top) {
                    Background()
                    
                    VStack(spacing: 0) {
                        Spacer().frame(height: 100) 
     
                        ExploreSearchBar(
                              text: $searchText,
                              placeholder: "Search",
                              asButton: true,
                              onRightButtonTap: {
//TODO: Open filter view
                                  
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
    }
    
    
}

// MARK: - Subviews

private struct Background: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .fill(Color(.accentBlue))
            .frame(height: 400)
            .offset(y: -200)
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
                            viewModel.isCategoryMode = false
                            viewModel.categoryEvents = []
                            await viewModel.fetchEvents(for: city)
                        }
                    }
                }
            } label: {
                LocationButtonView(city: selectedCity.title)
            }
            
            Spacer()
            
            Image(.bell)
            
        }
        .padding()
        .background(Color(.accentBlue))
        .foregroundColor(.white)
        .padding(.horizontal)
        .padding(.top, UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first?.safeAreaInsets.top ?? 0)
        .background(Color(.accentBlue))
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
                .font(.headline)
            Spacer()
            Button("See All") {
                viewModel.goToSeeAll(events)
            }
            .foregroundStyle(.customGray)
        }
        .padding(.horizontal, 25)
        
    }
        
}

private struct ExploreCategoryView: View {
    @ObservedObject var viewModel: ExploreViewModel
    let selectedCity: LocationsList
    
    var body: some View {
        CategoryScrollView { category in
            Task {
                await viewModel.fetchEventsBy(category: category, location: selectedCity)
            }
        }
        Spacer(minLength: 20)
    }
}
    
private struct ExploreFilterView: View {
    @ObservedObject var viewModel: ExploreViewModel
    
    var body: some View {
        FilterScrollView { filter in
            switch filter {
            case .today:
                viewModel.goToSeeAll(viewModel.todayEvents)
            case .films:
                viewModel.goToSeeAll(viewModel.movieEvents)
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
    
    var onBookmarkTap: (() -> Void)?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                if viewModel.isLoading {
                    // Skeleton
                    ForEach(0..<3, id: \.self) { _ in
                        ExploreCell(event: .mockConcert, isPlaceholder: true)
                    }
                } else {
                    ForEach(viewModel.isCategoryMode ? viewModel.categoryEvents : events, id: \.id) { event in
                        Button {
                            viewModel.goToDetail(event: event)
                        } label: {
                            ExploreCell(event: event, isPlaceholder: false) {
 // TODO: релизовать сохрание в закладки
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}



#Preview {
    ExploreView(viewModel: ExploreViewModel(router: Router()), events: Event.events)
}
